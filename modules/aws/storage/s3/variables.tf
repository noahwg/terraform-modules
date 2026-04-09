variable "name" {
  description = "Name of the S3 bucket."
  type        = string
}

variable "versioning_enabled" {
  description = "Whether to enable object versioning."
  type        = bool
  default     = false
}

variable "block_public_access" {
  description = "Whether to block all public access to the bucket."
  type        = bool
  default     = true
}

variable "force_destroy" {
  description = "Whether to allow Terraform to destroy the bucket even if it contains objects."
  type        = bool
  default     = false
}

variable "lifecycle_rules" {
  description = "List of lifecycle rules for the bucket."
  type = list(object({
    id      = string
    enabled = optional(bool, true)
    prefix  = optional(string)
    transitions = optional(list(object({
      days          = number
      storage_class = string
    })), [])
    expiration_days = optional(number)
  }))
  default = []
}

variable "logging_target_bucket" {
  description = "Name of the bucket to store access logs."
  type        = string
  default     = null
}

variable "logging_target_prefix" {
  description = "Prefix for access log objects."
  type        = string
  default     = null
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
