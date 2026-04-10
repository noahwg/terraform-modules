variable "name" {
  description = "Name of the S3 bucket."
  type        = string
}

variable "versioning_enabled" {
  description = "Whether to manage object versioning. Set to true to enable, false to suspend, or null to leave versioning unmanaged."
  type        = bool
  default     = null
}

variable "encryption_enabled" {
  description = "Whether to configure default server-side encryption for the bucket."
  type        = bool
  default     = true
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm to use by default."
  type        = string
  default     = "AES256"
}

variable "bucket_key_enabled" {
  description = "Whether to enable S3 Bucket Keys."
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

variable "bucket_policy_json" {
  description = "JSON bucket policy document to attach to the bucket."
  type        = string
  default     = null
}

variable "website_enabled" {
  description = "Whether to enable static website hosting for the bucket."
  type        = bool
  default     = false
}

variable "website_index_document" {
  description = "Index document suffix for static website hosting."
  type        = string
  default     = "index.html"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}
