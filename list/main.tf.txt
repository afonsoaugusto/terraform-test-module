variable "alias" {
  default     = ""
}

variable "records" {
  default     = ""
}

variable "records_list" {
  default     = ["33"]
}

variable "type" {
  default     = "A"
}

locals {
  records_list = var.records == "" ? var.records_list : list(var.records)
  records  = var.alias == "" ? var.type == "SRV" ? split(";",var.records) : local.records_list : null
}

output "records" {
  value       = local.records
}


Hoje o modulo terraform-r53-record-module pode receber listas de registros para os tipos  (SRV, NS, MX,TXT_MULTI).
Porém existe a função de balancer no rout53 para registros do Tipo A que não está sendo possivel ser feito, devido o modulo para outros tipos só receber String.


{code:hcl}
resource "aws_route53_record" "record" {
  zone_id  = data.aws_route53_zone.selected.zone_id
  name     = var.fqdn 
  type     = var.type == "TXT_MULTI" ? "TXT" : var.type
  ttl      = var.alias == "" ? var.ttl : null

  records  = var.alias == "" ? var.type == "SRV" || var.type == "NS" || var.type == "MX" || var.type == "TXT_MULTI" ? split(";",var.records) : list(var.records) : null

  dynamic "alias" {

    for_each = var.alias != "" ? zipmap(list(var.alias), list(var.alias)) : {}

    content {
      name    = var.alias
      zone_id = var.target_zone_id_alias
      evaluate_target_health = false
    }

  }
{code}


Portanto é necessário uma modificação para o mesmo.

Sugiro utilizar um locals auxiliar para utilizar como intermediario e aceitar a lista.

Sugestão:


{code:hcl}
variable "alias" {
  default     = ""
}

variable "records" {
  default     = ""
}

variable "records_list" {
  default     = ["33"]
}

variable "type" {
  default     = "A"
}

locals {
  records_list = var.records == "" ? var.records_list : list(var.records)
  records  = var.alias == "" ? var.type == "SRV" ? split(";",var.records) : local.records_list : null
}

output "records" {
  value       = local.records
}
{code}


Modificar modulo terraform-r53-record-module para tbm receber lista de registros para balancemento no dns.