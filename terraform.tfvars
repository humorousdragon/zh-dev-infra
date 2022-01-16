# AWS credentials

AWS_ACCESS_KEY_ID     = "AKIAYS7UALCRLQ3VD27A"
AWS_SECRET_ACCESS_KEY = "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"
AWS_DEFAULT_REGION    = "us-east-2"

# AWS_SSH_KEY_NAME = "mykey"

## Global Vars
aws_cluster_name = "zerohash-dev" #Develop for ZeroHash

## VPC Vars
aws_vpc_cidr_block       = "10.124.0.0/17"
aws_cidr_subnets_private = ["10.124.0.0/20", "10.124.16.0/20", "10.124.32.0/20"]
aws_cidr_subnets_public  = ["10.124.48.0/20", "10.124.64.0/20", "10.124.80.0/20"]
# vpn_cidr_blocks          = ["119.82.81.242/32", "217.111.141.168/29", "217.111.141.170/32", "180.151.81.146/32"]

default_tags = {
  Environment = "dev"
  Product     = "zerohash-dev"
  Terraformed = "1"
}


## EC2 Instances
aws_bastion_size = "t2.micro"

# ECR
ecr_repository_name = [
  "btc-spot-price"
]

## EKS Cluster Values
cluster-name    = "zerohash-dev"
node-group-name = "zerohash-dev-ng-1"
# dash-node-port  = 30982
api-node-port = 31472