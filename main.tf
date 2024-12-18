module "eks" {
  source = "./modules/eks"

  cluster_name = "test-cluster"
  prefix = "spylyp"
  cluster_version = "1.28"
  vpc_id = local.vpc_id
  subnets = local.subnet_ids
  tags = { "eks" = "test-cluster" }
  cluster_iam_role_name = "eks-cluster-role-tf"
  node_iam_role_name = "eks-node-role-tf"
}

