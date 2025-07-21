variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  default = "mybuckettest"
}

variable "force_destroy" {
  description = "Whether to force destroy all objects when deleting the bucket"
  type        = bool
  default     = false
}

variable "enable_versioning" {
  description = "Whether to enable versioning"
  type        = bool
  default     = false
}

variable "enable_mfa_delete" {
  description = "Whether to enable MFA delete"
  type        = bool
  default     = false
   
}

variable "enable_logging" {
  description = "Whether to enable bucket logging"
  type        = bool
  default     = false
}

variable "noncurrent_days" {
  description = "Number of days after which non-current versions expire"
  type        = number
  default     = 30
}
variable "expiration_days" {
  description = "Number of days after which the bucket expires"
  type        = number
  default     = 60
}

variable "attach_policy" {
  description = "Whether to attach a public read policy"
  type        = bool
  default     = false
}

variable "tags" {
  description = "A map of tags to apply to the bucket"
  type        = map(string)
  default = {}
}

variable "additional_tags" {
  description = "Extra tags to add on top of the default tags"
  type        = map(string)
  default     = {}
}

 variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use"
  type        = string
  default     = "AES256"

  validation {
    condition     = contains(["AES256", "aws:kms"], var.sse_algorithm)
    error_message = "sse_algorithm must be either 'AES256' or 'aws:kms'."
  }
}


 variable "versioning" {
  description = "Map to control versioning and MFA delete"
  type        = map(bool)
  default     = {}
}
variable "log_bucket_name" {
  description = "The name of the bucket to store logs (defaults to main bucket if empty)"
  type        = string
  default     = ""
}


variable "lifecycle_rule" {
  description = "List of maps containing configuration of object lifecycle management."
  type        = any
  default     = []
}