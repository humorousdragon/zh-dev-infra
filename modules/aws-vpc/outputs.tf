output "aws_vpc_id" {
  value = "${aws_vpc.cluster-vpc.id}"
}

output "aws_subnet_ids_private" {
  value = "${aws_subnet.cluster-vpc-subnets-private.*.id}"
}

output "aws_subnet_ids_public" {
  value = "${aws_subnet.cluster-vpc-subnets-public.*.id}"
}

output "default_tags" {
  value = "${var.default_tags}"
}

# output "aws_nat_eip" {
#   value = "${aws_eip.cluster-nat-eip.*.public_ip}"
# }

output "aws_nat_gateway_ip" {
  value = "${aws_nat_gateway.cluster-nat-gateway.*.public_ip}"
}

output "aws_k8s_sg" {
  value = "${aws_security_group.kubernetes.id}"
}

output "aws_bastion_sg" {
  value = aws_security_group.bastion.id
}

output "aws_k8s_alb_sg" {
  value = aws_security_group.k8s_alb.id
}