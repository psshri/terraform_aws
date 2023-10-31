# S3 ############################################

data "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-psshri-8441"
}

output "s3_arn" {
    value = aws_s3_bucket.s3_bucket.arn
}

output "s3_bucket_name" {
    value = aws_s3_bucket.s3_bucket.bucket
}