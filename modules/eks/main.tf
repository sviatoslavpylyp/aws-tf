module "eks_bottlerocket" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = "${var.prefix}-${var.cluster_name}"
  cluster_version = var.cluster_version
  enable_irsa = false

  enable_cluster_creator_admin_permissions = true

  # networking
  cluster_endpoint_public_access = true
  vpc_id     = var.vpc_id
  subnet_ids = var.subnets

  # cluster iam
  create_iam_role = true
  iam_role_name = var.cluster_iam_role_name
  iam_role_use_name_prefix = true

  # node iam
  create_node_iam_role = true
  node_iam_role_name = var.node_iam_role_name
  node_iam_role_use_name_prefix = true


  # EKS Addons
  cluster_addons = {
    coredns                = {
        most_recent = true
    }
    kube-proxy             = {
        most_recent = true
    }
    vpc-cni                = {
        most_recent = true
    }
  }

  # node group
  eks_managed_node_groups = {
    self_managed = {
      ami_type      = "BOTTLEROCKET_x86_64"
      instance_types = [ "t3.micro" ]
      capacity_type = "ON_DEMAND"
      create_launch_template = true

      min_size = 2
      max_size = 2
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
