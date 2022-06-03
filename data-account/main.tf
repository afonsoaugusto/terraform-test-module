data "aws_caller_identity" "this" {

}

output "data_account_id" {
  value       = data.aws_caller_identity.this
  description = "Account ID da conta de Dados"
}
