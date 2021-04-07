variable "name" {
  default = "654"  
}
variable "description" {
  default = ""
}

locals {
  description_alternative = format("Value for parameter %s", var.name)
  description = var.description == "" ? local.description_alternative : var.description
}

output "name" {
  value = local.description
}