# Bucket creation
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-psshri-8441"

  tags = {
    Environment = "dev"
  }
}

# Bucket ownership controls
resource "aws_s3_bucket_ownership_controls" "s3_bucket_ownership_controls" {
  bucket = aws_s3_bucket.s3_bucket.id
  rule {
    object_ownership = "ObjectWriter"
  }

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
}

# Bucket private access
resource "aws_s3_bucket_acl" "s3_bucket_acl" {
  bucket = aws_s3_bucket.s3_bucket.id
  acl    = "private"

  depends_on = [
    aws_s3_bucket.s3_bucket,
    aws_s3_bucket_ownership_controls.s3_bucket_ownership_controls
  ]
}

# Bucket versioning
resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Disabled"
  }
}

# Bucket public access
resource "aws_s3_bucket_public_access_block" "s3_bucket_access" {
  bucket = aws_s3_bucket.s3_bucket.id

  # Block public access
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}