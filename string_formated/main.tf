module "record_teste" {
  source  = "./module"
  type    = "TXT"
  records = "asdfasdfasdfasdfasdfasdfasdfasdfasdf\"\"qwerqwerqwerqwerqwerqqwerqwerqewrqwerqwerqewr"
  initial_string_record = "v=DKIM1; k=rsa;"
}

module "record" {
  source  = "./module"
  type    = "TXT"
  records = "teste.maxmilhas.com.br"
}

module "record_multi" {
  source  = "./module"
  type    = "TXT_MULTI"
  records = "teste;maxmilhas;com;br"
}

module "record_multi_parameter" {
  source                = "./module"
  type                  = "TXT_MULTI"
  records               = "teste;maxmilhas;com;br"
  initial_string_record = "v=DKIM1; k=rsa;"
}

module "record_null" {
  source                = "./module"
  type                  = "YYYY"
}


module "record_empty" {
  source = "./module"
}

module "record_A" {
  source  = "./module"
  type    = "A"
  alias = "d14u5dwi3mqere.cloudfront.net"
}

output "record_null" {
  description = "description"
  value       = module.record_null.records
}

output "record_null_base" {
  description = "description"
  value       = module.record_null.record_base
}

output "record" {
  description = "description"
  value       = module.record.records
}

output "record_multi" {
  description = "description"
  value       = module.record_multi.records
}

output "record_empty" {
  description = "description"
  value       = module.record_empty.records
}

output "record_empty_rest" {
  description = "description"
  value       = module.record_empty.record_remaining
}

output "record_multi_parameter" {
  description = "description"
  value       = module.record_multi_parameter.records
}

output "record_A" {
  description = "description"
  value       = module.record_A.records
}

output "record_teste" {
  description = "description"
  value       = module.record_teste.records
}
