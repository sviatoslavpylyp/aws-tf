data "aws_eks_cluster" "spylyp" {
  name = "spylyp"
}

data "aws_eks_cluster_auth" "spylyp" {
  name = "spylyp"
}