

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.16.0"
    }
  }
}

provider "aws" {
  # Configuration options
}


data "aws_acm_certificate" "issued" {
  domain   = "maxmilhas.com.br"
  statuses = ["ISSUED"]
}

output "acm" {
  value = data.aws_acm_certificate.issued
}
