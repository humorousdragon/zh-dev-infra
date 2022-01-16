variable cluster-name {
  type        = string
  description = "EKS Cluster Name"
}

variable eks_subnet_ids {
  description = "Subnet ids of eks cluster"
}

variable eks_sg_id {
  description = "Security group id of eks cluster"
}