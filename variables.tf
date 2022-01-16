variable "AWS_ACCESS_KEY_ID" {
  description = "AWS Access Key"
}

variable "AWS_SECRET_ACCESS_KEY" {
  description = "AWS Secret Key"
}

variable "AWS_DEFAULT_REGION" {
  description = "AWS Region"
}

variable "aws_cluster_name" {
  description = "Name of AWS Cluster"
}

variable "aws_vpc_cidr_block" {
  description = "CIDR Block for VPC"
}

variable "aws_cidr_subnets_private" {
  description = "CIDR Blocks for private subnets in Availability Zones"
  type        = list(string)
}

variable "aws_cidr_subnets_public" {
  description = "CIDR Blocks for public subnets in Availability Zones"
  type        = list(string)
}

# variable "vpn_cidr_blocks" {
#   description = "vpn cidr blocks"
#   # type        = list(string)
# }

variable "default_tags" {
  description = "Default tags for all resources"
  type        = map(string)
}

# variable "AWS_SSH_KEY_NAME" {
#   description = "Name of the SSH keypair to use in AWS. Public key should exist in this repository as `AWS_SSH_KEY_NAME.pub` file."
# }

# Bastion variables 

variable "aws_bastion_size" {
  description = "EC2 Instance Size of Bastion Host"
}


## ECR Variables
variable ecr_repository_name {
  description = "Name of the ECR repository"
  #	type = string
}

## EKS Cluster Variables

variable cluster-name {
  type        = string
  description = "EKS Cluster Name"
}

variable node-group-name {
  type        = string
  default     = ""
  description = "description"
}
variable node-cluster-name {
  type        = string
  default     = ""
  description = "description"
}

# variable dash-node-port {
#   description = "Node port of Dashboard Service"
# }

variable api-node-port {
  description = "Node port of Dashboard Service"
}

# variable node-group-name {
#   description = "Node port of Dashboard Service"
# }