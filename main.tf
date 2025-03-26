module "vpc" {
  source = "./modules/vpc"

  vpc_name = "spylyp-test"
  vpc_cidr = "10.0.0.0/16"
  asz = [ "us-west-2a", "us-west-2b", "us-west-2c", "us-west-2d" ]
  private_subnet_cirds = [ "10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19", "10.0.96.0/19" ]
  public_subnet_cirds = [ "10.0.128.0/19", "10.0.160.0/19", "10.0.192.0/19", "10.0.224.0/19" ]

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
  public_subnet_tags = {
    "kubernetes.io/role/elb"                    = "1"
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}

module "eks" {
  source = "./modules/eks"

  cluster_name = local.cluster_name
  cluster_version = "1.31"
  vpc_id = local.vpc_id
  subnets = local.private_subnet_ids
  cluster_iam_role_name = "eks-cluster-role-tf"
  node_iam_role_name = "eks-node-role-tf"
  tags = { 
    "eks" = "test-cluster" 
  }
}

# module "kube_prometheus_stack" {
#   source = "./modules/kube-prometheus-stack"

#   grafana_admin_password = "12345"
#   hostname = local.hostname
# }

module "cert_manager" {
  source = "./modules/cert-manager"
}

module "nginx_ingress" {
  source = "./modules/nginx-ingress-k8s"
}

module "argocd" {
  source = "./modules/argocd"

  hostname = local.hostname
  argo_admin_password = "MTIzNDUK"
}

module "sonarqube" {
  source = "./modules/sonarqube"
}

# module "metrics_server" {
#   source = "./modules/metrics-server"
# }
