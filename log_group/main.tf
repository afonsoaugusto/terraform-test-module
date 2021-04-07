# 

# 

# data "aws_kms_alias" "es" {
#   name = "alias/aws/es"
# }

# data "aws_kms_key" "by_alias_arn" {
#   key_id = "arn:aws:kms:us-east-1:254977422750:key/7334f23f-2e45-41a9-bdd2-bf628ca9b97a"
# }

# output "alias_arn" {
#   value = data.aws_kms_alias.es.arn
# }

# output "alias_id" {
#   value = data.aws_kms_alias.es.id
# }

# output "alias_target_key_id" {
#   value = data.aws_kms_alias.es.target_key_id
# }

# output "alias_target_key_arn" {
#   value = data.aws_kms_alias.es.target_key_arn
# }

# output "kms_target_key_arn_id" {
#   value = data.aws_kms_key.by_alias_arn.id
# }

# output "kms_target_key_arn_arn" {
#   value = data.aws_kms_key.by_alias_arn.arn
# }

# resource "random_password" "password" {
#   length  = 16
#   special = false
# }

# resource "local_file" "foo" {
#     content     = random_password.password.result
#     filename = "passwd.log"
# }

# resource "random_shuffle" "automated_snapshot_start_hour" {
#   input = [23,01,02,03]
#   result_count = 1
# }

# output "shuffle" {
#   value = random_shuffle.automated_snapshot_start_hour.result
# }
# variable "time" {
#   default = 10
# }
# resource "null_resource" "output-idd" {
#   provisioner "local-exec" {
#     command = format("sleep %s",var.time)
#   }
# }

# resource "null_resource" "aws-cli" {
#   provisioner "local-exec" {
#     command = format("aws command parameters")
#   }
# }

# # resource "local_file" "foo" {
# #     content     = random_password.password.result
# #     filename = "passwd.log"
# # }

# output "shuffle" {
#   value =  null_resource.output-id.id
#   # depends_on = [ "null_resource.output-id" ]
# }

variable "buckets" {
  default = ["a", "b"]
}

locals {
  buckets = toset(var.buckets)
}

data "aws_iam_policy_document" "access_policies" {
  for_each = local.buckets
  statement {
    actions = [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:ListBucketMultipartUploads",
        "s3:ListBucketVersions",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:AbortMultipartUpload",
        "s3:ListMultipartUploadParts"
    ]
    effect = "Allow"
    resources = [format("arn:aws:s3:::%s/", each.value),format("arn:aws:s3:::%s/*", each.value)]    
  }
}

output "policy0" {
  value = data.aws_iam_policy_document.access_policies["a"].json
}

# output "policy1" {|
#   value = data.aws_iam_policy_document.access_policies.1.json
# }


# resource "aws_elasticsearch_domain" "example" {
#   domain_name           = "tf-test"
#   elasticsearch_version = "7.9"
# }

# resource "aws_elasticsearch_domain_policy" "main" {
#   domain_name = aws_elasticsearch_domain.example.domain_name

#   access_policies = <<POLICIES
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "es:*",
#             "Principal": "*",
#             "Effect": "Allow",
#             "Condition": {
#                 "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
#             },
#             "Resource": "${aws_elasticsearch_domain.example.arn}/*"
#         }
#     ]
# }
# POLICIES
# }


# resource "aws_elasticsearch_domain_policy" "main2" {
#   domain_name = aws_elasticsearch_domain.example.domain_name

#   access_policies = <<POLICIES
# {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Action": "es:*",
#             "Principal": "*",
#             "Effect": "Allow",
#             "Condition": {
#                 "IpAddress": {"aws:SourceIp": "127.0.0.1/32"}
#             },
#             "Resource": "${aws_elasticsearch_domain.example.arn}/*"
#         }
#     ]
# }
# POLICIES
# }