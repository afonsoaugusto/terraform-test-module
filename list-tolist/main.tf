variable "vpc_tag_value" {
  default = "213as"
}

locals {
  abc = [var.vpc_tag_value]
}

output "vpc_tag_value" {
  value = local.abc
}
