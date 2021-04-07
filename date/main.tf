variable "stack_name" {
  default = "terraform-elasticsearch-module"
}
locals {
  date = formatdate("YYYYMMDDhhmmss", timestamp())
  bucket_name = substr(format("%s-%s",var.stack_name, local.date),0,63)
}

output "bucket_name" {
  value = local.bucket_name
}
resource "aws_s3_bucket" "b" {
  bucket = local.bucket_name
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}