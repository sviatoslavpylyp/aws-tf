output "vpc" {
  value = module.vpc
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}
