variable "instance_type" {
  default = "t2.micro"
}

variable "percentual" {
  default = 80
}

locals {
  memory_in_bytes_by_instance_type = {
    "t2.micro" = 2147483648
    "t3.nano"  = 1147483648
  }
  bytes = local.memory_in_bytes_by_instance_type[var.instance_type]
}

output "bytes" {
  value = local.memory_in_bytes_by_instance_type[var.instance_type]
}

output "percentual" {
  value = ceil(var.percentual / 100 * local.bytes)
}
