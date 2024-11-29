# IAM role for the EKS nodes (if you don't already have one)
resource "aws_iam_role" "this" {
  name = var.role_name

  assume_role_policy = var.assume_role_policy
}

resource "aws_iam_role_policy_attachment" "this" {
  count = length(var.policy_attachments)

  role = aws_iam_role.this.name
  policy_arn = count.index.policy_arn
}

# # Attach necessary policies to the role
# resource "aws_iam_role_policy_attachment" "this" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "eks_registry_policy" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }
