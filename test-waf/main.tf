module "ipset" {
  source             = "/home/afonsorodrigues/projetos/terraform-wafv2-ip-set-module"
  name               = "ipset-1"
  scope              = "CLOUDFRONT"
  description        = "test"
  ip_address_version = "IPV4"
  addresses          = ["1.2.3.4/32", "5.6.7.8/32"]
}

output "ip-arn" {
  value = module.ipset.arn
}

output "ip-set-rule" {
  value = module.ipset.ip_set_rule
}

module "webacl" {
  source       = "/home/afonsorodrigues/projetos/terraform-waf-module"
  name         = "test-local-waf"
  scope        = "CLOUDFRONT"
  env          = "homologation"
  ip_sets_rule = [module.ipset.ip_set_rule]
}
