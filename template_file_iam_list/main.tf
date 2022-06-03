variable "bucket_name" {
  default = "tf-test-bucket"
}

variable "role_arn" {
  type        = string
  description = "(optional) describe your variable"
  default     = "arn:aws:iam::123456789012:role/test-role"
}

variable "list_role_arn_aux" {
  type        = list(string)
  description = "(optional) describe your variable"
  default     = ["arn:aws:iam::123456789012:role/role_aux_1", "arn:aws:iam::123456789012:role/role_aux_2"]
}

locals {
  list_role_arns_bucket_policy_data = flatten([var.role_arn, []])
}

data "template_file" "bucket_policy_data" {
  template = file("${path.module}/templates/bucket_policy_data.json.tpl")
  vars = {
    bucket_name    = var.bucket_name
    list_role_arns = jsonencode(local.list_role_arns_bucket_policy_data)
  }
}

output "file" {
  value = data.template_file.bucket_policy_data.rendered
}
