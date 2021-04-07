# locals {
#   buckets_json_formated = jsonencode(formatlist("arn:aws:s3:::%s/*", var.buckets_s3))
# }

data "aws_iam_policy_document" "policy" {
  statement {
    actions = [
      "es:*",
      "logs:PutLogEvents",
      "logs:PutLogEventsBatch",
    ]

    resources = [format("arn:aws:es:%s:%s:domain/%s/*", data.aws_region.current.name, data.aws_caller_identity.current.account_id, local.domain_name)]

    effect = "Allow"

    principals {
      identifiers = ["es.amazonaws.com"]
      type        = "Service"
    }

    principals {
      identifiers = ["*"]
      type        = "AWS"
    }

  }
}

# data "aws_iam_policy_document" "anonymous_access_policies" {
# #   for_each = local.buckets
#   statement {
#     actions = [
#         "es:ESHttpPost"
#     ]

#     effect = "Allow"

#     principals {
#       identifiers = ["es.amazonaws.com"]
#       type        = "Service"
#     }

#     principals {
#       identifiers = ["*"]
#       type        = "AWS"
#     }
#     resources = [aws_elasticsearch_domain.es.arn]
#   }
# }

# resource "aws_elasticsearch_domain_policy" "anonymous" {
#   domain_name = aws_elasticsearch_domain.es.domain_name
#   access_policies = data.aws_iam_policy_document.s3_access_policies.json
# }


# data "aws_iam_policy_document" "s3_access_policies" {
# #   for_each = local.buckets
#   statement {
#     actions = [
#         "s3:ListBucket",
#         "s3:GetBucketLocation",
#         "s3:ListBucketMultipartUploads",
#         "s3:ListBucketVersions",
#         "s3:GetObject",
#         "s3:PutObject",
#         "s3:DeleteObject",
#         "s3:AbortMultipartUpload",
#         "s3:ListMultipartUploadParts"
#     ]

#     effect = "Allow"

#     principals {
#       identifiers = ["es.amazonaws.com"]
#       type        = "Service"
#     }

#     principals {
#       identifiers = ["*"]
#       type        = "AWS"
#     }
#     # resources = [format("arn:aws:s3:::%s/", each.value),format("arn:aws:s3:::%s/*", each.value)]    
#     resources = [format("arn:aws:s3:::%s/", "es-testing-local"),format("arn:aws:s3:::%s/*", "es-testing-local")]    
#   }
# }

# resource "aws_elasticsearch_domain_policy" "s3" {
#   domain_name = aws_elasticsearch_domain.es.domain_name
#   access_policies = data.aws_iam_policy_document.s3_access_policies.json
# }

# output "s3_access_policies_json" {
#   value = data.aws_iam_policy_document.s3_access_policies.json
# }


variable "buckets_s3" {
  default = ["a", "b"]
}

locals {
  formatlist_s3_base    = formatlist("arn:aws:s3:::%s/*", var.buckets_s3)
  formatlist_s3         = formatlist("arn:aws:s3:::%s/", var.buckets_s3)
  formatlist            = list(local.formatlist_s3_base, local.formatlist_s3)
  buckets_json_formated = jsonencode(flatten(local.formatlist))
  domain_name = "es-testing-local"
  length_bucket = length(var.buckets_s3)
}

data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "template_file" "policy" {
  template = "${file("${path.module}/policy.json.tpl")}"
  vars = {
    buckets_json_formated = local.buckets_json_formated
    aws_region = data.aws_region.current.name
    aws_caller_identity = data.aws_caller_identity.current.account_id
    domain_name = local.domain_name
    length_bucket = local.length_bucket
  }
}

resource "local_file" "foo" {
  content  = data.template_file.policy.rendered
  filename = "policy.json"
}


output "policy" {
  value = data.aws_iam_policy_document.policy.json
}