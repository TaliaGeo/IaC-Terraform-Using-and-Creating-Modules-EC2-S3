module "bucket1" {
  source            = "git::https://github.com/TaliaGeo/terraform-aws-s3-mpodule.git"
  bucket_name       = "reused-bucket-1"
  tags              = var.tags
  enable_versioning = true
  attach_policy     = true
}

module "bucket2" {
  source            = "git::https://github.com/TaliaGeo/terraform-aws-s3-mpodule.git"
  bucket_name       = "reused-bucket-2"
  tags              = var.tags
  enable_versioning = false
  attach_policy     = false
}
