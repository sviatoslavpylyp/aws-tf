terraform {
  backend "s3" {
    bucket         = "spylyp-remote-state"      # Your S3 bucket name
    key            = "third/terraform.tfstate"   # Path to the state file within the bucket
    region         = "us-west-2"                      # Your AWS region
    encrypt        = true                             # Enable encryption for the state file
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"  # Use the appropriate version
    }
  }
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"  # Path to your kubeconfig file
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.spylyp.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.spylyp.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.spylyp.token
}