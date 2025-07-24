# TERRAFORM-PROJECTS/outputs.tf

# Output the ID of the main VPC from the 'vpc' module.
output "main_vpc_id" {
  description = "The ID of the main VPC created by the 'vpc' module."
  value       = module.vpc.vpc_id
}

# Output the IDs of the private subnets from the 'vpc' module as a list.
output "main_vpc_private_subnet_ids" {
  description = "A list of IDs for the private subnets in the main VPC."
  value = [
    module.vpc.private_subnet1_id,
    module.vpc.private_subnet2_id
  ]
}

# Output the ID of the route table association for private subnet 1 from the 'vpc' module.
output "main_vpc_private_subnet1_assoc_id" {
  description = "The ID of the route table association for private subnet 1."
  value       = module.vpc.private_subnet1_assoc_subnet_id
}

# Output the ID of the private route table from the 'vpc' module.
output "main_vpc_private_route_table_id" {
  description = "The ID of the private route table associated with the private subnets in the main VPC."
  value       = module.vpc.private_route_table_id
}

# Output the ID of the Transit Gateway from the 'vpc' module.
output "main_transit_gateway_id" {
  description = "The ID of the Transit Gateway deployed via the 'vpc' module."
  value       = module.vpc.transit_gateway_id
}

# Output the ID of the Transit Gateway VPC attachment from the 'vpc' module.
output "main_transit_gateway_attachment_id" {
  description = "The ID of the Transit Gateway attachment to the main VPC."
  value       = module.vpc.transit_gateway_attachment_id
}
