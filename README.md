# AWS Infra using Terraform

This repo contains a set of modules for creating AWS resources using Terraform so that application can be deployed on kubernetes cluster. These modules include following resources:
- VPC
- EKS Cluster
- EKS worker node group
- Security Groups along with rules
- Load Balancer, target group and listener rules
- EC2 instance as bastion/jump host
- IAM roles

## Elastic Kubernetes Cluster
Amazon Elastic Kubernetes Service (Amazon EKS) is a managed container service to run and scale Kubernetes applications in the cloud or on-premises. Kubernetes is an open-source container orchestration system for automating software deployment, scaling, and management.

## To Create AWS resources using CI/CD:

1. `git clone` this repo to your computer.
2. Make changes as per your need. You can add or remove modules according to the requirements.
3. Install Terraform.
4. Values to various parameters e.g. CIDR is passed in `terraform.tfvars` file. You can pass your own values or leave it as is.
5. Open terraform.tfvars, set the aws access and secret key variables. You can change default region as well, currently us-east-2 is set.
6. Add changes by runnig `git add` and specifying files.
7. Commit your changes by running `git commit -m "Description"`
8. Push the code to the repo by running `git push -u origin master` after committing the changes.
9. This will trigger the CI/CD pipeline, which uses github actions, as pipeline workflow file (.github/workflows/terraform.yml) has been added to the repo. First it will checkout the repo on the runner. It will then setup terraform on the runner. After initialiazing terraform, it will check formatting and then run plan command which will show resources it will create. Finally it will run `terraform apply` command which will create the infrastructure.  
We will receive **slack notification** about job status. Once this job completes successfully we should see resources on our AWS console.  
**Note:** Please note that we are passing variable file `terraform.tfvars` so we have to add `-var=terraform.tfvars` with terraform plan and apply commands.

## To Create AWS resources from your PC:

1. `git clone` this repo to your computer.
2. Make changes as per your need. You can add or remove modules according to the requirements.
3. Install Terraform.
4. Values to various parameters e.g. CIDR is passed in `terraform.tfvars` file. You can pass your own values or leave it as is.
5. Open terraform.tfvars, set the aws access and secret key variables. You can change default region as well, currently us-east-2 is set.
6. Run `terraform init` to initialize providers.
7. Run `terraform validate` to validate the code, it would throw an error if there is any syntax error.
8. Run `terraform plan` to check which resources will be created.
9. Run `terraform apply`. It would ask for yes or no, please type yes and press Enter.


## Current Setup:
Currently resources mentioned above have been created within my AWS account. Terraform state for these resource is being maintained on Terraform cloud. Dashboard for kubernetes cluster has also been configured and can be accessed by following link:  

[Kubernetes Dashboard](https://spot.zerohash.online:444/)  

Token is provided in dash-token file in the repo.
