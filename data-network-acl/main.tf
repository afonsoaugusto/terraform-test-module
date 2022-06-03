
terraform {
  required_version = ">= 1.1.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.74.2"
    }
  }
}


variable "peer_crawly_cidr" {
  type        = string
  description = "CIDR crawly for peering connection"
  default     = "10.175.0.0/16"
}

variable "peer_crawly_open_ports" {
  type = list(object({
    rule_number = number
    port        = number
    protocol    = string
  }))
  description = "CIDR crawly for peering connection"
  default = [{
    rule_number = 10,
    port        = 80,
    protocol    = "tcp"
    },
    {
      rule_number = 11,
      port        = 443,
      protocol    = "tcp"
  }]
}


module "vpc" {
  source        = "git@bitbucket.org:maxmilhas/terraform-datasource-aws-vpc-module.git?ref=v0.0.3"
  vpc_tag_name  = "mm_product"
  vpc_tag_value = "1"
}


data "aws_network_acls" "nacls" {
  vpc_id = module.vpc.id

  tags = {
    mm_product = "1"
  }
}

locals {
  nacl_id = tolist(data.aws_network_acls.nacls.ids)[0]
}

output "nacl" {
  description = "value of the first network ACL"
  value       = local.nacl_id
}

resource "aws_network_acl_rule" "open_port" {
  count          = length(var.peer_crawly_open_ports)
  network_acl_id = local.nacl_id
  rule_number    = var.peer_crawly_open_ports[count.index].rule_number
  egress         = false
  protocol       = var.peer_crawly_open_ports[count.index].protocol
  rule_action    = "allow"
  cidr_block     = var.peer_crawly_cidr
  from_port      = var.peer_crawly_open_ports[count.index].port
  to_port        = var.peer_crawly_open_ports[count.index].port
}

resource "aws_network_acl_rule" "close_port" {
  network_acl_id = local.nacl_id
  rule_number    = 90
  egress         = false
  protocol       = "-1"
  rule_action    = "deny"
  cidr_block     = var.peer_crawly_cidr
  from_port      = -1
  to_port        = -1
}
