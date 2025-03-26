module "eks_bottlerocket" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.cluster_name}"
  cluster_version = var.cluster_version
  enable_irsa = true

  enable_cluster_creator_admin_permissions = true

  # networking
  cluster_endpoint_public_access = true
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  # cluster iam
  create_iam_role = true
  iam_role_name = var.cluster_iam_role_name
  iam_role_use_name_prefix = true

  # # node iam
  # create_node_iam_role = true
  # node_iam_role_name = var.node_iam_role_name
  # node_iam_role_use_name_prefix = true

  # EKS Addons
  cluster_addons = {
    coredns                = {
      most_recent = false
      version = "v1.11.4-eksbuild.1"
    }
    kube-proxy             = {
      most_recent = false
      version = "v1.31.3-eksbuild.2"
    }
    vpc-cni                = {
      most_recent = false
      version = "v1.19.2-eksbuild.1"
      resolve_conflicts = "OVERWRITE"
      configuration_values = jsonencode({
        env = {
          # Reference docs https://docs.aws.amazon.com/eks/latest/userguide/cni-increase-ip-addresses.html
          ENABLE_PREFIX_DELEGATION = "true"
          WARM_PREFIX_TARGET       = "1"
          WARM_IP_TARGET           = "5"
          MINIMUM_IP_TARGET        = "2"
        }
      })
    }
    eks-pod-identity-agent = {
      most_recent = false
      version = "v1.3.4-eksbuild.1"
    }
  }

  # node group
  eks_managed_node_groups = {
    self_managed = {
      ami_type      = "AL2023_x86_64_STANDARD"
      instance_types = [ "t3.small" ]
      capacity_type = "ON_DEMAND"
      create_launch_template = true

      min_size = 2
      max_size = 3
      desired_size = 2

      labels = {
        type = "nodegroup"
      }
    }
  }

  # sg
  node_security_group_additional_rules = {
    ingress_self_all = {
      description = "Node to node all ports/protocols"
      protocol    = "-1"
      from_port   = 0
      to_port     = 0
      type        = "ingress"
      self        = true
    }
    ingress_control_plane = {
      description                   = "Master to nodes all TCP"
      protocol                      = "-1"
      from_port                     = 0
      to_port                       = 0
      type                          = "ingress"
      source_cluster_security_group = true
    }
    egress_all = {
      description      = "Node all egress"
      protocol         = "-1"
      from_port        = 0
      to_port          = 0
      type             = "egress"
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  tags = var.tags
}



# resource "aws_iam_policy" "rds_eks_policy" {
#   name = "rds-connect-policy"

#   policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Action": "rds-db:connect",
#         "Resource": "arn:aws:rds-db:us-west-2:245582572290:dbuser:db-WODKVUP7T7C5SNSPYVUKPXK5AU/postgres"
#       }
#     ]
#   })
# }

# resource "aws_iam_role" "eks_rds_access" {
#   name = "eks-s3-access"

#   assume_role_policy = jsonencode({
#     "Version": "2012-10-17",
#     "Statement": [
#       {
#         "Effect": "Allow",
#         "Principal": {
#           "Federated": "${module.eks_bottlerocket.oidc_provider_arn}"
#         },
#         "Action": "sts:AssumeRoleWithWebIdentity",
#         "Condition": {
#           "StringEquals": {
#             "${replace(module.eks_bottlerocket.oidc_provider, "https://", "")}:sub": "system:serviceaccount:default:rds-access-sa",
#             "${replace(module.eks_bottlerocket.oidc_provider, "https://", "")}:aud": "sts.amazonaws.com"
#           }
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_rds_access_attachment" {
#   role = aws_iam_role.eks_rds_access.name
#   policy_arn = aws_iam_policy.rds_eks_policy.arn
# }
