provider "aws" {
  region = "us-east-1"
}

# variable "map_variable_default" {
#   description = "description"
#   default = {
#     Environment = "env-default"
#     Application = "app-default"
#     DeployedBY  = "Terraform"
#   }
# }

# variable "map_variable_imp" {
#   description = "description"
#   default = {
#     Environment = "env-variable2"
#     Sug         = "sug-variable2"
#   }
# }

# variable "map_variable_imp_default" {
#   type        = map
#   description = "description"
#   default     = {}
# }

# locals {
#   key = merge(var.map_variable_default, var.map_variable_imp, var.map_variable_imp_default)
# }

# output "variable_default" {
#   value = var.map_variable_default
# }

# output "variable_imp" {
#   value = var.map_variable_imp
# }

# output "variable_applied" {
#   value = local.key
# }

variable "s3_origin" {
  type = list(map(string))
  default = [
    {
      domain_name = "mm-test-module-hmg-3.s3.amazonaws.com"
      origin_id   = "test-module-3"
    },
    {
      domain_name = "mm-test-module-hmg-1.s3.amazonaws.com"
      origin_id   = "test-module-1"
    },
    {
      domain_name = "mm-test-module-hmg-2.s3.amazonaws.com"
      origin_id   = "test-module-2"
    },
  ]
}

output "s3_origin" {
  value = var.s3_origin
}

# data "aws_s3_bucket" "selected" {
#   bucket = "resale-miles-params-ui-hmg"
# }

# output "aws_s3_bucket_selected" {
#   value = data.aws_s3_bucket.selected
# }

data "aws_s3_bucket" "s3_reference" {
  count = length(var.s3_origin)
  # for_each = var.s3_origin
  bucket = replace(lookup(var.s3_origin[count.index], "domain_name"), ".s3.amazonaws.com", "")
}

output "aws_s3_bucket_count" {
  value = data.aws_s3_bucket.s3_reference
}

data "aws_iam_policy_document" "s3_policy" {
  count = length(var.s3_origin)
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${data.aws_s3_bucket.s3_reference[count.index].arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity[count.index].iam_arn]
    }
  }
}

output "aws_iam_policy_document_s3_policy" {
  value = data.aws_iam_policy_document.s3_policy[*].json
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  count   = length(var.s3_origin)
  comment = lookup(var.s3_origin[count.index], "origin_id")
}

output "aws_cloudfront_origin_access_identity_origin_access_identity" {
  value = aws_cloudfront_origin_access_identity.origin_access_identity
}

resource "aws_s3_bucket_policy" "example" {
  count  = length(var.s3_origin)
  bucket = data.aws_s3_bucket.s3_reference[count.index].bucket
  policy = data.aws_iam_policy_document.s3_policy[count.index].json
}

output "aws_s3_bucket_policy_example" {
  value = aws_s3_bucket_policy.example
}