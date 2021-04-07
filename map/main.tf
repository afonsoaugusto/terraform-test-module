
variable "db_role_readAnyDatabase" {
  default = false
}

variable "db_role_readWriteAnyDatabase" {
  default = false
}

variable "db_role_clusterMonitor" {
  default = false
}

variable "db_role_dbAdminAnyDatabase" {
  default = false
}

variable "db_role_enableSharding" {
  default = false
}

variable "db_role_backup" {
  default = false
}

variable "db_role_atlasAdmin" {
  default = false
}

locals {
  map_roles_admin = map(
    "readAnyDatabase", var.db_role_readAnyDatabase,
    "readWriteAnyDatabase", var.db_role_readWriteAnyDatabase,
    "clusterMonitor", var.db_role_clusterMonitor,
    "dbAdminAnyDatabase", var.db_role_dbAdminAnyDatabase,
    "enableSharding", var.db_role_enableSharding,
    "backup", var.db_role_backup,
    "atlasAdmin", var.db_role_atlasAdmin,

  )
  filter_roles_admin_enabled = matchkeys(keys(local.map_roles_admin), values(local.map_roles_admin), ["true"])
}

output "list_priv" {
  value = local.filter_roles_admin_enabled
}

locals {
  default_value = list("readAnyDatabase")
  list_keys     = ["admin", "admin2"]
  setproduct    = setproduct(local.list_keys, local.default_value)
  flatten       = flatten(local.setproduct)
  map           = local.setproduct
  test          = flatten([for k in local.list_keys : { "readAnyDatabase" = k }])
}

# output "map" {
#     value = local.map
# }

# output "test" {
#     value = local.test
# }