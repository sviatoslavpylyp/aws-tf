variable "role_name" {
  type = string
}

variable "assume_role_policy" {
  type = string
}

variable "policy_attachments" {
  type = list(string)
  default = [  ]
}
