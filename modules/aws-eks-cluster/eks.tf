resource "aws_eks_cluster" "default" {
  name = var.cluster-name

  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = 1.21

  vpc_config {

    subnet_ids              = var.eks_subnet_ids
    security_group_ids      = ["${var.eks_sg_id}"]
    public_access_cidrs     = ["0.0.0.0/0"]
    endpoint_private_access = "true"
    endpoint_public_access  = "true"
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.AmazonEKSVPCResourceController,
  ]
}

resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-role"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

resource "aws_iam_role_policy_attachment" "AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster-role.name
}

# locals {
#   certificate_authority_data_list = coalescelist(
#     aws_eks_cluster.default.*.certificate_authority,
#     [
#       [
#         {
#           "data" = ""
#         },
#       ],
#     ],
#   )
#   certificate_authority_data_list_internal = local.certificate_authority_data_list[0]
#   certificate_authority_data_map           = local.certificate_authority_data_list_internal[0]
#   certificate_authority_data               = local.certificate_authority_data_map["data"]
# }

# data "template_file" "kubeconfig" {
#   template = file("${path.module}/kubeconfig.tpl")

#   vars = {
#     server                     = join("", aws_eks_cluster.default.*.endpoint)
#     certificate_authority_data = local.certificate_authority_data
#     cluster_name               = var.cluster-name
#   }
# }
