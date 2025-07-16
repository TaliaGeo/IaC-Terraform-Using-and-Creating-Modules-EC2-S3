locals {
  default_tags = {
    Name      = var.project_name
    Environment = var.environment
    Owner     = var.owner
    ManagedBy = var.ManagedBy
  }

   tags = merge(local.default_tags, var.tags)
}