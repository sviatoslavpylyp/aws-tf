resource "aws_eks_node_group" "new_node_group" {
  cluster_name    = var.cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn

  # Node group settings
  scaling_config {
    desired_size = 2
    max_size     = 2
    min_size     = 1
  }

  instance_types = var.instance_types

  subnet_ids = var.subnet_ids

  ami_type = "AL2_x86_64" 

  tags = {
    Environment = "dev"
    Project     = "spylyp"
  }
}
