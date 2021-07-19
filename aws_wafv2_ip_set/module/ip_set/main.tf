terraform {
  required_version = ">= 0.12.31"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.39.0"
    }
  }
}

variable "name" {
  type        = string
  description = "A friendly name of the IP set."
}

variable "description" {
  type        = string
  description = "A friendly description of the IP set."
  default     = ""
}

variable "scope" {
  type        = string
  description = "Specifies whether this is for an AWS CloudFront distribution or for a regional application. Valid values are CLOUDFRONT or REGIONAL"
}

variable "ip_address_version" {
  type        = string
  description = "Specify IPV4 or IPV6. Valid values are IPV4 or IPV6."
}

variable "addresses" {
  type        = list(string)
  description = "Contains an array of strings that specify one or more IP addresses or blocks of IP addresses in Classless Inter-Domain Routing (CIDR) notation. AWS WAF supports all address ranges for IP versions IPv4 and IPv6."
}

variable "priority" {
  type        = number
  description = "Set priority for use in a WebACL."
  default     = 1
}

variable "action" {
  type        = string
  description = "Set action for use in a WebACL. Valid values are ALLOW, BLOCK, or COUNT."
  default     = "ALLOW"
}

variable "tags" {
  default     = {}
  type        = map(string)
  description = "Tags for resources"
}

locals {
  common_tags = {
    Name          = var.name
    Stack         = var.name
    ProvisionedBy = "Terraform"
  }
  default_description = "An IP set created by Terraform"
  description         = var.description == "" ? local.default_description : var.description
  tags                = merge(local.common_tags, var.tags)
}

resource "aws_wafv2_ip_set" "ip_set" {
  name               = var.name
  description        = local.description
  scope              = var.scope
  ip_address_version = var.ip_address_version
  addresses          = var.addresses
  tags               = local.tags
}

output "id" {
  sensitive   = false
  value       = aws_wafv2_ip_set.ip_set.id
  description = "A unique identifier for the set."
}

output "arn" {
  sensitive   = false
  value       = aws_wafv2_ip_set.ip_set.arn
  description = "The Amazon Resource Name (ARN) that identifies the cluster."
}

output "tags_all" {
  sensitive   = false
  value       = aws_wafv2_ip_set.ip_set.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider."
}

output "ip_set_rule" {
  description = "Object for use in module terraform-waf-module"
  sensitive   = false
  value = {
    "name" : var.name,
    "priority" : var.priority,
    "ip_set_arn" : aws_wafv2_ip_set.ip_set.arn,
    "action" : var.action
  }
}
