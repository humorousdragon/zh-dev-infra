#### Module EKS

module "aws-eks-cluster" {
  source = "./modules/aws-eks-cluster"

  cluster-name   = var.cluster-name
  eks_subnet_ids = split(",", join(",", module.aws-vpc.aws_subnet_ids_private, module.aws-vpc.aws_subnet_ids_public))
  eks_sg_id      = module.aws-vpc.aws_k8s_sg
}

module "aws-eks-node" {
  source              = "./modules/aws-eks-node"
  node-cluster-name   = module.aws-eks-cluster.eks_cluster_name
  node-group-name     = var.node-group-name
  ec2-ssh-key         = "zh-dev-eks-node"
  source-sg-id        = module.aws-vpc.aws_bastion_sg
  eks-node-subnet-ids = module.aws-vpc.aws_subnet_ids_private
}

module "aws-lb-api" {
  source = "./modules/aws-lb"

  lb-name         = "api-gateway"
  alb-sg-id       = module.aws-vpc.aws_k8s_alb_sg
  alb-subnet-id   = module.aws-vpc.aws_subnet_ids_public
  alb-tg-name     = "api-lb-tg"
  tg-protocol     = "HTTP"
  node-port       = var.api-node-port
  vpc-id          = module.aws-vpc.aws_vpc_id
  alb-certificate = "arn:aws:acm:us-east-2:590532860066:certificate/770f6553-1a31-4536-a9e4-a230dfea1a92"
}

# module "aws-lb-dash" {
#   source = "./modules/aws-lb"

#   lb-name         = "zh-dev-dash"
#   alb-sg-id       = module.aws-vpc.aws_k8s_alb_sg
#   alb-subnet-id   = module.aws-vpc.aws_subnet_ids_public
#   alb-tg-name     = "dash-lb-tg"
#   tg-protocol     = "HTTPS"
#   node-port       = var.dash-node-port
#   vpc-id          = module.aws-vpc.aws_vpc_id
#   alb-certificate = "arn:aws:acm:us-east-2:590532860066:certificate/770f6553-1a31-4536-a9e4-a230dfea1a92"
# }

resource "aws_autoscaling_attachment" "ng-asg-alb-api" {
  autoscaling_group_name = module.aws-eks-node.node-asg-id
  alb_target_group_arn   = module.aws-lb-api.tg-arn
}

# resource "aws_autoscaling_attachment" "ng-asg-alb-dash" {
#   autoscaling_group_name = module.aws-eks-node.node-asg-id
#   alb_target_group_arn   = module.aws-lb-dash.tg-arn
# }