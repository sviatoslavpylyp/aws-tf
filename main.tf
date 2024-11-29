# module "eks_cluster_role" {
#   source = "./modules/iam_role"

#   role_name = "spylyp-node-role"
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Action    = "sts:AssumeRole"
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#         Effect    = "Allow"
#         Sid       = ""
#       },
#     ]
#   })

#   policy_attachments = [
#     "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
#     "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
#     "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
#   ]
# }

# module "eks_node_group" {
#   source = "./modules/eks-node-group"

#   cluster_name = "spylyp"
#   node_group_name = "self-managed-1"
#   node_role_arn = "arn:aws:iam::245582572290:role/spylyp-self-managed-nodegroup-2"
#   subnet_ids = [ "subnet-fffb1087", "subnet-faaabfb1", "subnet-9808f2c5", "subnet-42cfbd69" ]
#   instance_types = [ "t3.micro" ]
# }

resource "helm_release" "argocd" {
  name = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart = "argocd"
  version = "2.13.1"

  namespace = "argocd"

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "server.service.annotations.service\\.beta\\.kubernetes\\.io/aws-load-balancer-type"
    value = "nlb"
  }
}
