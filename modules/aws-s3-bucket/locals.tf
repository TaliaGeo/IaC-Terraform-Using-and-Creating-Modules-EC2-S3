locals {
  create_logging = var.enable_logging && var.log_bucket_name != ""
   final_log_bucket_name = var.log_bucket_name != "" ? var.log_bucket_name : var.bucket_name
   use_versioning = length(keys(var.versioning)) > 0
    merged_tags = merge(
    var.tags,
    var.additional_tags,
    {
      ManagedBy = "Terraform"
    }
  )

 lifecycle_rules = length(var.lifecycle_rule) > 0 ? var.lifecycle_rule : [
  {
    id              = "archive-temp"
    status          = "Enabled"
    expiration_days = var.expiration_days
    noncurrent_days = var.noncurrent_days
  }
]//Use the user’s lifecycle rules if provided, otherwise use a default rule.
 


}