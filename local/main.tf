module "users" {
  source = "./module"
  users = [{
    username = "test",
    password = "test"
  }]
}

output "users" {
  value = module.users.users
}
