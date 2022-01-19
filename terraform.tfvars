# AWS credentials

AWS_ACCESS_KEY_ID     = ""
AWS_SECRET_ACCESS_KEY = ""
AWS_DEFAULT_REGION    = "us-east-2"

# AWS_SSH_KEY_NAME = "mykey"

## Global Vars
aws_cluster_name = "zerohash-dev" #Develop for ZeroHash

## VPC Vars
aws_vpc_cidr_block       = "10.124.0.0/17"
aws_cidr_subnets_private = ["10.124.0.0/20", "10.124.16.0/20", "10.124.32.0/20"]
aws_cidr_subnets_public  = ["10.124.48.0/20", "10.124.64.0/20", "10.124.80.0/20"]

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