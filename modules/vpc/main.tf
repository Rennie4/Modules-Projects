resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "main-vpc"
  }
}


# Data source to get available availability zones in the current region
data "aws_availability_zones" "available" {
  state = "available"
}


resource "aws_subnet" "private_subnet1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet1_cidr
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.private_subnet2_cidr
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet2"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_subnet1_assoc" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private_subnet2_assoc" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt.id
}


# Transit Gateway
resource "aws_ec2_transit_gateway" "tgw" {

  default_route_table_association = "enable"
  default_route_table_propagation = "enable"

  tags = {
    Name = "transit_gateway"
  }
}

# Transit Gateway VPC Attachment
resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  vpc_id             = aws_vpc.main.id
  subnet_ids         = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "transit_gateway_attachment_main_vpc"
  }
}

# Route to Transit Gateway
resource "aws_route" "tgw_route" {
  route_table_id         = aws_route_table.private_rt.id
  destination_cidr_block = var.transit_gateway_destination_cidr
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id
}

# These will associate the VPC attachment with the TGW's default route table (due to TGW settings)
# and propagate the VPC's CIDR to it.
resource "aws_ec2_transit_gateway_route_table_association" "main_vpc_tgw_rt_association" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment.id
  # If you rely on the default TGW route table, you can reference it like this:
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw.association_default_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "main_vpc_tgw_rt_propagation" {
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment.id
  # If you rely on the default TGW route table, you can reference it like this:
  transit_gateway_route_table_id = aws_ec2_transit_gateway.tgw.propagation_default_route_table_id
}
