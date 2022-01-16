output "node-asg-id" {
  description = "ASG ID"
  value       = aws_eks_node_group.eks-node-group.resources[0].autoscaling_groups[0].name
}

output "node-role-arn" {
  value       = aws_iam_role.node-group-role.arn
  description = "Node iam role arn"
}