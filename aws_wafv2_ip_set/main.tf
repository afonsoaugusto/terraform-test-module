locals {
  tags = {
    Name        = "test_name",
    Description = "test_description"
  }
}

variable "scope" {
  type        = string
  description = "(optional) describe your variable"
  default     = "CLOUDFRONT"
}

module "name" {
  source             = "./module/ip_set"
  tags               = local.tags
  addresses          = ["1.2.3.4/32", "5.6.7.8/32"]
  ip_address_version = "IPV4"
  name               = "Teste"
  scope              = var.scope
}

module "name2" {
  source             = "./module/ip_set"
  tags               = local.tags
  addresses          = ["1.2.3.4/32", "5.6.7.8/32"]
  ip_address_version = "IPV4"
  name               = "Teste2"
  scope              = "REGIONAL"
}

output "ip_set_rule" {
  value = module.name.ip_set_rule
}

output "ip_set_rule1" {
  value = module.name2.ip_set_rule
}
