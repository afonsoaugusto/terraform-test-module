locals {
  es_arn = "arn:aws:es:us-east-1:254977422750:domain/es-platform"
}

data "template_file" "logging_policy" {
  template = file("${path.module}/templates/logging-policy.json.tpl")
  vars = {
    es_arn = jsonencode(local.es_arn)
  }
}

output "policy" {
  value = data.template_file.logging_policy.rendered
}
