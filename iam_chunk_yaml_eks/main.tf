variable "project_name" {
  default = "eks-logs-kcloud-2309"
  type    = string
}

variable "product_names" {
  default = ["spring-cloud-data-flow"]
  type    = list(string)
}

locals {
  regex_for_remove_quota = "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/"
  namespaces             = distinct(flatten(list(var.product_names, list(var.project_name))))
}

locals {
  withOIDC           = map("withOIDC", true)
  vpc                = map("iam", merge(local.withOIDC, local.service_accounts))
  iam_chunk          = yamlencode(local.vpc)
  iam_chunk_cleaning = replace(local.iam_chunk, local.regex_for_remove_quota, "$1$2:")
}

locals {
  role = "123"
}

data "template_file" "eks_yml" {
  template = file("${path.module}/eks.yml.tpl")
  vars = {
    iam_chunk                 = local.iam_chunk_cleaning
    arn_custom_role           = local.role
    name_for_custom_role      = "312"
    namespace_for_custom_role = "31"

  }
}

resource "local_file" "eks_yml_file" {
  content  = data.template_file.eks_yml.rendered
  filename = "eks.yml"
}
