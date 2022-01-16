terraform {
  required_version = ">= 0.12"
  # backend "s3" {
  #   bucket = "zh-terraform-state"
  #   key    = "infra-state/terraform-dev.tfstate"
  #   region = "us-east-2"
  # }
}

terraform {
  cloud {
    organization = "ankjnn"

    workspaces {
      name = "gh-actions-zh-infra"
    }
  }
}
provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.AWS_DEFAULT_REGION
}

module "aws-vpc" {
  source = "./modules/aws-vpc"

  aws_cluster_name         = var.aws_cluster_name
  aws_vpc_cidr_block       = var.aws_vpc_cidr_block
  aws_avail_zones          = slice(data.aws_availability_zones.available.names, 0, 3)
  aws_cidr_subnets_private = var.aws_cidr_subnets_private
  aws_cidr_subnets_public  = var.aws_cidr_subnets_public
  # vpn_cidr_blocks          = var.vpn_cidr_blocks
  default_tags      = var.default_tags
  eks_cluster_sg_id = module.aws-eks-cluster.eks_cluster_sg_id
}

# resource "aws_key_pair" "k8s-ssh-key" {
#   key_name   = "${var.AWS_SSH_KEY_NAME}"
#   public_key = "${file("${var.AWS_SSH_KEY_NAME}.pub")}"
# }


#### Bastion EC2 Instance

resource "aws_instance" "bastion-server" {
  ami           = data.aws_ami.distro.id
  instance_type = var.aws_bastion_size
  #  count                       = "${length(var.aws_cidr_subnets_public)}"
  count                       = 1
  associate_public_ip_address = true
  # availability_zone           = "${element(slice(data.aws_availability_zones.available.names, 0, 2), count.index)}"
  subnet_id              = element(slice(module.aws-vpc.aws_subnet_ids_public, 0, 2), count.index)
  vpc_security_group_ids = ["${module.aws-vpc.aws_bastion_sg}"]
  key_name               = "zh-dev-bastion"

  credit_specification {
    cpu_credits = "standard"
  }
}

#### IAM Module

# module "aws-iam" {
#   source = "./modules/aws-iam"
# }


module "aws-ecr" {
  source = "./modules/aws-ecr"

  count               = length(var.ecr_repository_name)
  ecr_repository_name = var.ecr_repository_name[count.index]
}