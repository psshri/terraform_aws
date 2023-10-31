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

# IAM Role ######################################

output "iam_role_arn" {
    value = aws_iam_role.lambda_role.arn
}

output "iam_role_id" {
    value = aws_iam_role.lambda_role.id
}

# IAM Policy ####################################

output "iam_policy_arn" {
    value = aws_iam_policy.s3_policy.arn
}