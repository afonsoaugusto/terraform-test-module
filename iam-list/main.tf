variable "bucket_list" {
  type        = list(string)
  description = "(optional) describe your variable"
  default     = ["abc", "abc3"]
}

variable "bucket_name" {
  type        = string
  description = "(optional) describe your variable"
  default     = "abc"
}

locals {
  bucket_arn_list        = [for item in var.bucket_list : "arn:aws:s3:::${item}"]
  bucket_list_for_policy = flatten([[for item in local.bucket_arn_list : "${item}/*"], local.bucket_arn_list])
}

output "bucket_list_for_policy" {
  value = local.bucket_list_for_policy
}

data "aws_iam_policy_document" "policy" {
  statement {
    sid = "1"

    actions = [
      "s3:GetObject"
    ]

    resources = local.bucket_list_for_policy
  }
}

output "policy" {
  value = data.aws_iam_policy_document.policy.json
}
