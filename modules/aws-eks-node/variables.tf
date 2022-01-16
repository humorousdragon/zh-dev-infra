variable "node-group-name" {
  type        = string
  default     = ""
  description = "description"
}

variable "node-cluster-name" {
  type        = string
  default     = ""
  description = "description"
}

variable "ec2-ssh-key" {
  description = "SSH key for nodes"
}

variable "source-sg-id" {

}

variable "eks-node-subnet-ids" {
  description = "Subnet ids for node group"
}