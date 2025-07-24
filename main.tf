module "vpc" {
  source = "./modules/vpc" # Changed from "modules/vpc"
  region                           = "eu-west-1"
vpc_cidr                         = "10.0.0.0/16"
private_subnet1_cidr             = "10.0.1.0/24"
private_subnet2_cidr             = "10.0.2.0/24"
transit_gateway_destination_cidr = "10.100.0.0/16" # Example: another VPC's CIDR

  
}