terraform {
  required_version = "= 0.12.31"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.17.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_lb_target_group" "front_end" {
  name     = "tf-lb-test-two-listeners-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-4c86142a"
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.test.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}

resource "aws_lb_listener_certificate" "com_br" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = "arn:aws:acm:us-east-1:254977422750:certificate/b2bbe902-4045-4e57-93cb-6531bb286196"
}

resource "aws_lb_listener_certificate" "com" {
  listener_arn    = aws_lb_listener.front_end.arn
  certificate_arn = "arn:aws:acm:us-east-1:254977422750:certificate/555a0d1c-7c3e-4c43-95fd-d989cc184573"
}


resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["subnet-de497097", "subnet-65418102"]

  enable_deletion_protection = false

  tags = {
    Environment = "production"
  }
}
