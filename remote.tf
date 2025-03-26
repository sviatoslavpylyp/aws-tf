terraform {
  backend "s3" {
    bucket         = ""      # Your S3 bucket name
    key            = "third/terraform.tfstate"   # Path to the state file within the bucket
    region         = "us-west-2"                      # Your AWS region
    encrypt        = true                             # Enable encryption for the state file
  }

  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}
