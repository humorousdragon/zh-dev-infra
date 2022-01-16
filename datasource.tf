data "aws_availability_zones" "available" {}

data "aws_region" "elastic_region" {}

data "aws_caller_identity" "current" {}

data "aws_ami" "distro" {
  most_recent = true

  filter {
    name   = "image-id"
    values = ["ami-0e84e211558a022c0"]
  }


  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"]
}