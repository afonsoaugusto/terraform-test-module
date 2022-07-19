
variable "domain" {
  type = map(object(
    {
      domain_name               = string
      subject_alternative_names = list(string)
    }
  ))
  default = {
    "elb.res.prv.hmg.maxmilhas.com" = {
      domain_name               = "elb.res.prv.hmg.maxmilhas.com"
      subject_alternative_names = ["value"]
    },
    "hmg.maxmilhas.com" = {
      domain_name               = "hmg.maxmilhas.com"
      subject_alternative_names = ["value"]
    }
  }
}

data "aws_route53_zone" "selected" {
  for_each = var.domain
  #   name     = var.domain[each.key].domain_name
  name = each.value.domain_name
}

# data "aws_route53_zone" "selected" {
#   name = "hmg.maxmilhas.com"
# }

output "domain_nmae" {
  value = data.aws_route53_zone.selected["hmg.maxmilhas.com"]
}

# output "domain" {
#   value = var.domain
# }

# output "domain_name" {
#   value = var.domain["elb.res.prv.hmg.maxmilhas.com"].domain_name
# }

# output "domain_name" {
#   value = { for domain in var.domain : domain.domain_name => domain }
# }
