variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "subnets" {
  type = list(string)
}

variable "tags" {
  type = map(string)
}

variable "cluster_iam_role_name" {
  type = string
}

variable "node_iam_role_name" {
  type = string
}
