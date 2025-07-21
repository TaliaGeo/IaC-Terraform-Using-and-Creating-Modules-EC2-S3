resource "aws_s3_bucket" "this" {
  bucket = var.bucket_name
  force_destroy = var.force_destroy  
    tags =local.merged_tags
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.sse_algorithm
    }
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  bucket = aws_s3_bucket.this.id
  count  = length(local.lifecycle_rules) > 0 ? 1 : 0

  dynamic "rule" {
    for_each = local.lifecycle_rules
    content {
      id     = rule.value.id
      status = rule.value.status

      expiration {
        days = rule.value.expiration_days
      }

      noncurrent_version_expiration {
        noncurrent_days = rule.value.noncurrent_days
      }
    }
  }
}

resource "aws_s3_bucket_logging" "example" {
  count         = local.create_logging ? 1 : 0
  bucket        = aws_s3_bucket.this.id
  target_bucket = local.final_log_bucket_name
  target_prefix = "log/"
}

resource "aws_s3_bucket_versioning" "this" {
 count = length(keys(var.versioning)) > 0 ? 1 : 0
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = try(
      var.versioning["enable_versioning"] ? "Enabled" : "Suspended",
      "Suspended"
    )
    mfa_delete = try(
      var.versioning["enable_mfa_delete"] ? "Enabled" : "Disabled",
      "Disabled"
    )
  }
}

resource "aws_s3_bucket_policy" "this" {
  count = var.attach_policy ? 1 : 0

  bucket = aws_s3_bucket.this.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.this.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.attach_policy ? 1: 0

  bucket = aws_s3_bucket.this.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
