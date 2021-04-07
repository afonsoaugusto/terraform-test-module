variable "type" {
  
  default     = "A"
}

variable "records" {
  
  description = "description"
  default     = ""
}

variable "alias" {
  
  description = "description"
  default     = ""
}

variable "initial_string_record" {
  
  description = "description"
  default     = ""
}

locals {
  record_base  = var.type == "SRV" || var.type == "NS" || var.type == "MX" || var.type == "TXT_MULTI" ? split(";",var.records) : list(var.records)
  
  record_0 = element(local.record_base, 0)
  record_0_wiht_parameter = list(join("",[var.initial_string_record,local.record_0]))
  record_remaining = slice(local.record_base, 1, length(local.record_base))
  records = var.alias == "" ? flatten(list(local.record_0_wiht_parameter, local.record_remaining)) : null
}

output "record_remaining" {
  description = "description"
  value       = local.record_remaining
}

output "record_base" {
  description = "description"
  value       = local.record_base
}

output "records" {
  description = "description"
  value       = local.records
}
