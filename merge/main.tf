variable "map_variable_default" {
  description = "description"
  default = {
    Environment = "env-default"
    Application = "app-default"
    DeployedBY  = "Terraform"
  }
}

variable "map_variable_imp" {
  description = "description"
  default = {
    Environment = "env-variable2"
    Sug         = "sug-variable2"
  }
}

variable "map_variable_imp_default" {
  type        = map
  description = "description"
  default     = {}
}

variable "name" {
  default = "name"
}

locals {
  key  = merge(var.map_variable_default, var.map_variable_imp, var.map_variable_imp_default)
  key2 = merge(map("Name", var.name), var.map_variable_default)
  key3 = local.key2
}

output "variable_default" {
  value = var.map_variable_default
}

output "variable_imp" {
  value = var.map_variable_imp
}

output "variable_applied" {
  value = local.key
}

output "k2" {
  value = local.key2
}
output "k3" {
  value = local.key3
}