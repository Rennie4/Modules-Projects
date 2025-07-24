output "vpc_id" {
  value = aws_vpc.main.id
}

output "private-subnet1_id" {
  value = aws_subnet.private_subnet1.id
}

output "private-subnet2_id" {
  value = aws_subnet.private_subnet2.id
}

output "private_subnet1_assoc_subnet_id" {
  value = aws_route_table_association.private_subnet1_assoc.id

}



output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_rt.id
}

output "transit_gateway_id" {
  description = "ID of the Transit Gateway"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "transit_gateway_attachment_id" {
  description = "ID of the Transit Gateway VPC attachment"
  value       = aws_ec2_transit_gateway_vpc_attachment.tgw_attachment.id
}
