resource "aws_s3_bucket" "artifacts_bucket" {
  bucket = var.artifact_bucket_name
  tags   = var.tags
}

resource "aws_s3_bucket_acl" "artifacts_bucket_acl" {
  bucket = aws_s3_bucket.artifacts_bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_public_access_block" "artifacts_bucket_block_public_access" {
  bucket = aws_s3_bucket.artifacts_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact_bucket_server_side_encryption" {
  bucket = aws_s3_bucket.artifacts_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
    bucket_key_enabled = false
  }
}

resource "aws_s3_bucket_policy" "artifact_bucket_policy" {
  bucket = aws_s3_bucket.artifacts_bucket.id
  policy = templatefile("${path.module}/templates/artifacts-bucket.tftpl",
    {
      bucket-name = aws_s3_bucket.artifacts_bucket.id
    }
  )
}