variable "vpc_tag_name" {
  default = "mm_product"
}

variable "vpc_tag_value" {
  default = "1"
}

data "aws_vpc" "selected" {
  filter {
    name   = format("tag:%s", var.vpc_tag_name)
    values = list(var.vpc_tag_value)
  }
}

resource "aws_security_group" "allow_tls2" {
  name        = "allow_tls321"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [data.aws_vpc.selected.cidr_block]
  }

  tags = {
    Name = "allow_tls2"
  }
}


data "aws_security_group" "selected" {
  filter {
    name   = format("tag:%s", "Name")
    values = list("allow_tls")
  }
}


resource "aws_security_group_rule" "example" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = data.aws_security_group.selected.id
  source_security_group_id = aws_security_group.allow_tls2.id
}

output "id_reference" {
  value = data.aws_security_group.selected.id
}
