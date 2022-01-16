resource "aws_lb" "sub-alb" {
  name               = var.lb-name
  internal           = false
  load_balancer_type = "application"
  security_groups    = ["${var.alb-sg-id}"]
  subnets            = var.alb-subnet-id

  enable_deletion_protection = true

  tags = {
    Environment = "prodevd"
  }
}

## Instance Target Group
resource "aws_lb_target_group" "sub-alb-tg" {
  name     = var.alb-tg-name
  port     = var.node-port
  protocol = var.tg-protocol
  vpc_id   = var.vpc-id
}

## Load Balancer Listeners
## Forward Action
resource "aws_lb_listener" "sub-alb-list" {
  load_balancer_arn = aws_lb.sub-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.alb-certificate

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.sub-alb-tg.arn
  }
}

## Redirect Action

resource "aws_lb_listener" "sub-alb-list-r" {
  load_balancer_arn = aws_lb.sub-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}