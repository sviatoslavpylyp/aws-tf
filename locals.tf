locals {
  vpc_id = data.terraform_remote_state.state.outputs.vpc_id
  private_subnet_ids = data.terraform_remote_state.state.outputs.private_subnet_ids

  cluster_name = ""

  hostname = ""
}
