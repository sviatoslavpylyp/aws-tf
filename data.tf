data "terraform_remote_state" "state" {
  backend = "s3" 
  config = {
    bucket  = "spylyp-remote-state"
    key     = "third/terraform.tfstate"
    region  = "us-west-2"
  }
}
