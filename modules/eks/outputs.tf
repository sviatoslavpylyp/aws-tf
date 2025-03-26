output "cluster_endpoint" {
  value = module.eks_bottlerocket.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks_bottlerocket.cluster_certificate_authority_data
}

output "cluster_name" {
  value = module.eks_bottlerocket.cluster_name
}

output "cluster_oidc_arn" {
  value = module.eks_bottlerocket.oidc_provider_arn
}

output "cluster_oidc_url" {
  value = module.eks_bottlerocket.oidc_provider
}
