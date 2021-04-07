variable "lifecycle_rule" {
  type = object({
    id         = string
    prefix     = string
    enabled    = string
    expiration = map(string)
  })
  default = {
    id      = "tmp"
    prefix  = "tmp/"
    enabled = true

    expiration = {
      date = "2016-01-12"
    }
  }
}

# resource "aws_s3_bucket" "bucket" {
#   bucket = "my-bucket-lifecycle-rule-test"
#   acl    = "private"

# #   lifecycle_rule { 
# #       var.lifecycle_rule
# #     }
# }

output "lifecycle_rule" {
  value = var.lifecycle_rule
}