variable "s3_bucket_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "teste-bcp"
}

locals {
  #   engine_name = "s3"
  engine_name                       = "aurora"
  s3_role                           = ""
  s3_create_role_verify_role_arn    = local.s3_role == "" ? true : false
  s3_create_role_verify_engine_name = local.engine_name == "s3" ? true : false
  s3_create_role                    = local.s3_create_role_verify_engine_name == true && local.s3_create_role_verify_role_arn == true ? 1 : 0
  endpoint_type                     = "source"
  s3_role_actions_target = [
    "s3:PutObject",
    "s3:DeleteObject",
    "s3:PutObjectTagging"
  ]
  s3_role_actions_source = [
    "s3:GetObject"
  ]
  actions = local.endpoint_type == "target" ? local.s3_role_actions_target : local.s3_role_actions_source
}

data "aws_iam_policy_document" "dms_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      identifiers = ["dms.amazonaws.com"]
      type        = "Service"
    }
  }
}


# output "dms_assume_role_json" {
#   value = data.aws_iam_policy_document.dms_assume_role.json
# }

resource "aws_iam_role" "dms-access-for-endpoint" {
  count              = local.s3_create_role
  assume_role_policy = data.aws_iam_policy_document.dms_assume_role.json
  name               = "s3-dms-endpoint-role"
}

data "aws_iam_policy_document" "s3" {
  statement {
    sid = "1"

    actions = local.actions
    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}",
    ]
  }

}

output "aws_iam_policy_document_s3_json" {
  value = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_policy" "policy" {
  count  = local.s3_create_role
  name   = "example_policy_s3_test"
  path   = "/"
  policy = data.aws_iam_policy_document.s3.json
}

resource "aws_iam_role_policy_attachment" "dms-access-for-endpoint-AmazonDMSRedshiftS3Role" {
  count      = local.s3_create_role
  policy_arn = aws_iam_policy.policy[count.index].arn
  role       = aws_iam_role.dms-access-for-endpoint[count.index].name
}

output "s3_create_role" {
  value = local.s3_create_role
}

