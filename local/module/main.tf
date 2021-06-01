variable "users" {
  type = list(object({
    password = string,
    username = string
    }
  ))
  description = "Configuration block for broker users. For engine_type of RabbitMQ."
  default     = []
}

output "users" {
  value = var.users
}
