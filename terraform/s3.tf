# Bucket creation
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-psshri-8441"

  tags = {
    Environment = "dev"
  }
}

# # Bucket private access
# resource "aws_s3_bucket_acl" "s3_bucket_acl" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   acl    = "private"
# }

# # Enable bucket versioning
# resource "aws_s3_bucket_versioning" "s3_bucket_versioning" {
#   bucket = aws_s3_bucket.s3_bucket.id
#   versioning_configuration {
#     status = "Enabled"
#   }
# }

# # Enable default Server Side Encryption
# resource "aws_s3_bucket_server_side_encryption_configuration" "s3_bucket_server_side_encryption" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   rule {
#     apply_server_side_encryption_by_default {
#         kms_master_key_id = aws_kms_key.kms_s3_key.arn
#         sse_algorithm     = "aws:kms"
#     }
#   }
# }

# # Creating Lifecycle Rule
# resource "aws_s3_bucket_lifecycle_configuration" "s3_bucket_lifecycle_rule" {
#   # Must have bucket versioning enabled first
#   depends_on = [aws_s3_bucket_versioning.s3_bucket_versioning]

#   bucket = aws_s3_bucket.s3_bucket.id

#   rule {
#     id = "basic_config"
#     status = "Enabled"

#     filter {
#       prefix = "config/"
#     }

#     noncurrent_version_transition {
#       noncurrent_days = 30
#       storage_class   = "STANDARD_IA"
#     }

#     noncurrent_version_transition {
#       noncurrent_days = 60
#       storage_class   = "GLACIER"
#     }
    
#     noncurrent_version_expiration {
#       noncurrent_days = 90
#     }
#   }
# }

# # Disabling bucket public access
# resource "aws_s3_bucket_public_access_block" "s3_bucket_access" {
#   bucket = aws_s3_bucket.s3_bucket.id

#   # Block public access
#   block_public_acls   = true
#   block_public_policy = true
#   ignore_public_acls = true
#   restrict_public_buckets = true
# }