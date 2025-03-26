variable "vpc_name" {
  type = string
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "asz" {
  type = list(string)
}

variable "private_subnet_cirds" {
  type = list(string)
}

variable "public_subnet_cirds" {
  type = list(string)
}

variable "tags" {
  type = map(string)
  default = {}
}

variable "private_subnet_tags" {
  type = map(string)
}

variable "public_subnet_tags" {
  type = map(string)
}

