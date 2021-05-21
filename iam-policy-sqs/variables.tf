data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

variable "project_name" {
  type        = string
  description = "description"
  default     = "testmodule"
}

variable "list_sqs" {
  type        = list(string)
  description = "SQS name for access publish"
  default     = ["SQS-hmg-flights-monitor-provider-amadeus", "SQS-hmg-automatic-cancelation-process-grant-credit"]
}

locals {
  tags = {
    Name  = var.project_name
    Tribo = "Infraestrutura"
  }
}

