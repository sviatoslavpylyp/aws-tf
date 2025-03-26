module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  enable_dns_hostnames = true
  enable_dns_support = true

  azs             = var.asz
  private_subnets = var.private_subnet_cirds
  public_subnets  = var.public_subnet_cirds

  # nat gw
  enable_nat_gateway = true
  single_nat_gateway = true

  # igw
  create_igw = true

  
  
  public_subnet_tags = var.public_subnet_tags
  private_subnet_tags = var.private_subnet_tags

  tags = var.tags
}
