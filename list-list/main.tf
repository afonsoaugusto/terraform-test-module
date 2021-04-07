variable "bucket" {
  type = string
  default = "1213"
}

variable "bucketlist" {
  type = list(string)
  default = ["asdf","657"]
}

locals {
  buckets = flatten(list(list(var.bucket), var.bucketlist))
}

output "list" {
  value = local.buckets
}