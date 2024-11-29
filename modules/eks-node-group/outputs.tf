output "node_group_id" {
  value = aws_eks_node_group.new_node_group.id
}

output "node_group_arn" {
  value = aws_eks_node_group.new_node_group.arn
}
