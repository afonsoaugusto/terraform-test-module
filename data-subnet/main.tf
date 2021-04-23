provider "aws" {
  region = "us-east-1"
}

variable "vpc_tag_name" {
  default = "mm_product"
}

variable "vpc_tag_value" {
  default = "1"
}

variable "regions" {
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

data "aws_vpc" "vpc" {
  filter {
    name   = format("tag:%s", var.vpc_tag_name)
    values = list(var.vpc_tag_value)
  }
}


# output "vpc_id" {
#   value = data.aws_vpc.vpc.id
# }

data "aws_subnet_ids" "subnets" {
  for_each = toset(var.regions)
  vpc_id   = data.aws_vpc.vpc.id

  filter {
    name   = format("tag:%s", var.vpc_tag_name)
    values = list(var.vpc_tag_value)
  }

  filter {
    name   = "availabilityZone"
    values = [each.key]
  }
}

output "ids" {
  value = data.aws_subnet_ids.subnets["us-east-1a"].ids
}

# export AWS_REGION=us-east-1


data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

locals {
  list_subnets_private = [for region in var.regions :
    map(region,
      map("id", element(
        tolist(data.aws_subnet_ids.subnets[region].ids), 0
        )
      )
  )]
  map_subnets_private = zipmap(
    flatten(
      [for item in local.list_subnets_private : keys(item)]
    ),
    flatten(
      [for item in local.list_subnets_private : values(item)]
    )
  )
}

output "map_subnets_private" {
  value = local.map_subnets_private
}

locals {
  id                     = map("id", data.aws_vpc.vpc.id)
  cidr                   = map("cidr", data.aws_vpc.vpc.cidr_block)
  subnets_private        = map("private", local.map_subnets_private)
  subnets                = map("subnets", local.subnets_private)
  vpc                    = map("vpc", merge(local.id, local.cidr, local.subnets))
  vpc_chunk              = yamlencode(local.vpc)
  regex_for_remove_quota = "/((?:^|\n)[\\s-]*)\"([\\w-]+)\":/"
  vpc_chunk_cleaning     = replace(local.vpc_chunk, local.regex_for_remove_quota, "$1$2:")
}


data "template_file" "yml" {
  template = file("${path.module}/file.yml.tpl")
  vars = {
    vpc_id    = data.aws_vpc.vpc.id
    vpc_cidr  = data.aws_vpc.vpc.cidr_block
    subnets   = yamlencode(data.aws_subnet_ids.subnets)
    vpc_chunk = local.vpc_chunk_cleaning
  }
}

resource "local_file" "yml_file" {
  content  = data.template_file.yml.rendered
  filename = "${path.module}/file.yml"
}