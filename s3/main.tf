module "life" {
  source         = "./module"
  lifecycle_rule = [{ "id" : "teste", "transition" : [{ "id2" : "fdaskdhf" }] }]
}

output "lifecycle_rule" {
  value = module.life.lifecycle_rule
}

output "id" {
  value = lookup(module.life.lifecycle_rule[0], "id", "default")
}

output "transition" {
  value = lookup(module.life.lifecycle_rule[0], "transition", [])
}

map = {
    "teste":"teste",
    "id":"teste654"
}

lookup(map, "tre", "oiu")
if value is null
    return oiu
 return value =  teste


 aws s3api get-bucket-lifecycle-configuration --bucket  mm-datalake-prd-transfer-to-gcp --output json > lifecycle-policy.json 
 aws s3api get-bucket-lifecycle-configuration --bucket  mm-prd-elasticsearch-backup --output json > lifecycle-policy-glacier.json 