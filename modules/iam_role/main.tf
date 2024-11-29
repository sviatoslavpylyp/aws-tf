# IAM role for the EKS nodes (if you don't already have one)
resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  count = length(var.policy_attachments)

  role = aws_iam_role.this.name
  policy_arn = var.policy_attachments[count.index]
}
