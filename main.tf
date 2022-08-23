terraform {
  cloud {
    organization = "module-terra-demo"

    workspaces {
      name = "1-demo-tuna"
    }
  }
}
//--------------------------------------------------------------------
// Variables
variable "ec2_instance_associate_public_ip_address" {}




//--------------------------------------------------------------------
// Modules
module "ec2_instance" {
  source  = "app.terraform.io/democom/ec2-instance/aws"
  version = "1.0.0"

  ami = "ami-0c956e207f9d113d5"
  associate_public_ip_address = "${var.ec2_instance_associate_public_ip_address}"
  availability_zone = "eu-central-1a"
  subnet_id = "${module.vpc.public_subnets}"
  vpc_security_group_ids = "${module.security_group.security_group_vpc_id}"
}

module "rds" {
  source  = "app.terraform.io/democom/rds/aws"
  version = "1.0.0"

  identifier = "rds"
}

module "security_group" {
  source  = "app.terraform.io/democom/security-group/aws"
  version = "1.0.0"
}

module "vpc" {
  source  = "app.terraform.io/democom/vpc/aws"
  version = "1.0.0"
  assign_ipv6_address_on_creation = "false"
  azs = "eu-central-1a eu-central-1b"
  cidr = "10.0.0.0/16"
  create_database_internet_gateway_route = "false"
  create_database_nat_gateway_route = "false"
  create_database_subnet_group = "true"
  create_database_subnet_route_table = "false"
  create_egress_only_igw = "true"
  create_elasticache_subnet_group = "true"
  create_elasticache_subnet_route_table = "false"
  create_flow_log_cloudwatch_iam_role = "false"
  create_flow_log_cloudwatch_log_group = "false"
  create_igw = "true"
  create_redshift_subnet_group = "false"
  create_redshift_subnet_route_table = "false"
  create_vpc = "true"
  database_dedicated_network_acl = "false"
  default_vpc_name = "my-vpc"
  private_subnets = ["private-subnet-1" , "private-subnet-2","private-subnet-3" , "private-subnet-4"]
  public_subnets = ["public-subnet-1" , "public-subnet-2"]
  single_nat_gateway = "true"
  tags {
    Name = "my-vpc"
  }
}