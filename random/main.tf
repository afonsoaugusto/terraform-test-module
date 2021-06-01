terraform {
  required_version = ">= 0.12.0"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0"
    }
  }
}

variable "length" {
  default     = 16
  type        = number
  description = "The length of the string desired."
}

variable "keepers" {
  default     = null
  type        = map(string)
  description = "Arbitrary map of values that, when changed, will trigger recreation of resource. See the main provider documentation for more information."
}

variable "lower" {
  default     = null
  type        = bool
  description = "Include lowercase alphabet characters in the result."
}

variable "min_lower" {
  default     = null
  type        = number
  description = "Minimum number of lowercase alphabet characters in the result."
}

variable "min_numeric" {
  default     = null
  type        = number
  description = "Minimum number of numeric characters in the result."
}

variable "min_special" {
  default     = null
  type        = number
  description = "Minimum number of special characters in the result."
}

variable "min_upper" {
  default     = null
  type        = number
  description = "Minimum number of uppercase alphabet characters in the result."
}

variable "number" {
  default     = null
  type        = bool
  description = "Include numeric characters in the result."
}

variable "override_special" {
  default     = null
  type        = string
  description = "Supply your own list of special characters to use for string generation. This overrides the default character list in the special argument. The special argument must still be set to true for any overwritten characters to be used in generation."
}

variable "special" {
  default     = false
  type        = bool
  description = "Include special characters in the result. These are !@#$%&*()-_=+[]{}<>:?"
}

variable "upper" {
  default     = null
  type        = bool
  description = "Include uppercase alphabet characters in the result."
}

resource "random_password" "password" {
  length           = var.length
  keepers          = var.keepers
  lower            = var.lower
  min_lower        = var.min_lower
  min_numeric      = var.min_numeric
  min_special      = var.min_special
  min_upper        = var.min_upper
  number           = var.number
  override_special = var.override_special
  special          = var.special
  upper            = var.upper
}

output "id" {
  description = "A static value used internally by Terraform, this should not be referenced in configurations."
  sensitive   = false
  value       = random_password.password.id
}

output "result" {
  description = "The generated random string."
  sensitive   = true
  value       = random_password.password.result
}
