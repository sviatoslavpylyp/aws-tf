output "role_id" {
  value = aws_iam_role.this.id
}

output "policy_ids" {
  value = aws_iam_role_policy_attachment.this[*].id
}

output "role_arn" {
  value = aws_iam_role.this.arn
}