output iam-node-role {
  value       = "${aws_iam_role.node-role.arn}"
  description = "Node role arn"
}
