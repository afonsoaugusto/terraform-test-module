variable "vpcs" {
  description = "Map de VPCs para serem criadas"
  type        = map(any)
  default = {
    "abs" = {
      "casa" = "abs"
    },
    "rew" = {
      "casa" = "rew"
    }
  }
}

module "a" {
  source   = "./modules/a"
  for_each = var.vpcs
  name     = each.value.casa
}

module "b" {
  source   = "./modules/b"
  for_each = var.vpcs
  name     = module.a[each.key].name
}

output "name-module-a" {
  value = module.a["abs"].name
}

output "name-module-b" {
  value = module.b.*
}
