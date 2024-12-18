terraform {
  backend "s3" {
    bucket         = "spylyp-remote-state"      # Your S3 bucket name
    key            = "third/terraform.tfstate"   # Path to the state file within the bucket
    region         = "us-west-2"                      # Your AWS region
    encrypt        = true                             # Enable encryption for the state file
  }
}
