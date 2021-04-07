variable "vpc_tag_name" {
  default = ""
}

variable "vpc_tag_value" {
  default = ""
}

data "aws_vpc" "vpc" {
  filter {
    name   = format("tag:%s", var.vpc_tag_name)
    values = list(var.vpc_tag_value)
  }
}

output "id" {
  value = data.aws_vpc.vpc.id
}

output "cidr_block" {
  value = data.aws_vpc.vpc.cidr_block
}


variable "subnet_tag_name" {
  default = ""
}

variable "subnet_tag_value" {
  default = ""
}

variable "subnet_tag_value_list" {
  type    = list(any)
  default = []
}

data "aws_subnet_ids" "subnets" {
  vpc_id = data.aws_vpc.vpc.id

  filter {
    name   = format("tag:%s", var.subnet_tag_name)
    values = var.subnet_tag_value != "" ? list(var.subnet_tag_value) : var.subnet_tag_value_list
  }
}

output "ids" {
  value = data.aws_subnet_ids.subnets.ids
}
