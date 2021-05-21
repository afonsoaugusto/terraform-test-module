data "aws_sqs_queue" "sqs" {
  for_each = toset(var.list_sqs)
  name     = each.value
}

locals {
  role_name    = format("%s-ROLE", var.project_name)
  policy_name  = format("%s-POLICY", var.project_name)
  list_sqs_arn = [for sqs in var.list_sqs : data.aws_sqs_queue.sqs[sqs].arn]
}

data "template_file" "policy" {
  template = file("${path.module}/templates/policy.json.tpl")
  vars = {
    aws_region          = data.aws_region.current.name
    aws_caller_identity = data.aws_caller_identity.current.account_id
    role_name           = local.role_name
    list_sqs_arn        = jsonencode(local.list_sqs_arn)
  }
}

data "template_file" "assume_role" {
  template = "${file("${path.module}/templates/assume_role.json.tpl")}"
}

resource "aws_iam_role" "role" {
  name               = local.role_name
  assume_role_policy = data.template_file.assume_role.rendered
  tags               = local.tags
}

resource "aws_iam_role_policy" "iam_policy" {
  name   = local.policy_name
  role   = aws_iam_role.role.id
  policy = data.template_file.policy.rendered
}

output "policy_id" {
  value = aws_iam_role_policy.iam_policy.id
}

output "policy_name" {
  value = aws_iam_role_policy.iam_policy.name
}

output "role_arn" {
  value = aws_iam_role.role.arn
}

output "role_id" {
  value = aws_iam_role.role.id
}

output "role_name" {
  value = aws_iam_role.role.name
}

