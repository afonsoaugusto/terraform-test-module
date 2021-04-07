variable "variable_name" {
  type    = list
  default = ["default"]
}

output "variable" {
  value = var.variable_name
}