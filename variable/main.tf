# variable "variable_name" {
#   type    = list(any)
#   default = ["default"]
# }

# output "variable" {
#   value = var.variable_name
# }

variable "cloud_provider" {
  type        = string
  default     = "AWS"
  description = "Name of the cloud provider (GCP)"
  sensitive   = false
  validation {
    condition     = contains(["GCP"], var.cloud_provider)
    error_message = "Valid values for var: cloud_provider are (GCP)."
  }
}

output "cloud_provider" {
  value = var.cloud_provider
}
