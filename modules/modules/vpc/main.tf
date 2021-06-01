variable "name" {
  type        = string
  description = "alguma coisa"
}

# resource "aws_vpc" "main" {
#   cidr_block = "10.0.0.0/16"
# }

output "name" {
  value     = var.name
  sensitive = false
}
