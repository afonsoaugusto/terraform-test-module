
output "json" {
  value = jsonencode({ rules = [{ filters = [], object-locator = { schema-name = "accounts", table-name = "%" }, rule-action = "include", rule-id = "1", rule-name = "1", rule-type = "selection" }, ] })
}

