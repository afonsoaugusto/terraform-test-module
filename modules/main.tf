
module "vpc" {
  source = "./modules/vpc"
  name   = "Teste VPC"
}

output "name-vpc" {
  value = module.vpc.name
}


module "ingestion" {
  source = "./modules/ingestion"
  name   = "Teste ingestion"
}

output "name-ingestion" {
  value = module.ingestion.name
}
