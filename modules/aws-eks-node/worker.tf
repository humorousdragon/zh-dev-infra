resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = var.node-cluster-name
  node_group_name = var.node-group-name
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = var.eks-node-subnet-ids
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  remote_access {
    ec2_ssh_key               = var.ec2-ssh-key
    source_security_group_ids = ["${var.source-sg-id}"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.AmazonEC2ContainerRegistryReadOnly
  ]
}

resource "aws_iam_role" "node-group-role" {
  name = "eks-node-group-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonSQSFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonS3FullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AWSQuickSightElasticsearchPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSQuickSightElasticsearchPolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AWSCloudFormationFullAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AWSCloudFormationFullAccess"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "AutoScalingReadOnlyAccess" {
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingReadOnlyAccess"
  role       = aws_iam_role.node-group-role.name
}