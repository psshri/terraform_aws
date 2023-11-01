# S3 ############################################

data "aws_s3_bucket" "s3_bucket" {
  bucket = "s3-bucket-psshri-8441"

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]
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
  value = aws_iam_policy.s3_sns_policy.arn
}

# Lambda ########################################

output "lambda_arn" {
  value = aws_lambda_function.lambda_function.arn
}

output "lambda_id" {
  value = aws_lambda_function.lambda_function.id
}

output "lambda_invoke_arn" {
  value = aws_lambda_function.lambda_function.invoke_arn
}

output "lambda_function_name" {
  value = aws_lambda_function.lambda_function.function_name
}

# SNS ###########################################

output "sns_topic_arn" {
  value = aws_sns_topic.sns_topic.arn
}

output "sns_topic_subscription_arn" {
  value = aws_sns_topic_subscription.sns_topic_subscription.arn
}

# API GW ########################################

output "apigw_id" {
  value = aws_apigatewayv2_api.http_api.id
}

output "apigw_endpoint" {
  value = aws_apigatewayv2_api.http_api.api_endpoint
}

output "apigw_arn" {
  value = aws_apigatewayv2_api.http_api.arn
}

output "apigw_execution_arn" {
  value = aws_apigatewayv2_api.http_api.execution_arn
}

output "apigw_integration_id" {
  value = aws_apigatewayv2_integration.http_api_integration.id
}

# output "test" {
#   value = aws_apigatewayv2_deployment.http_api_deployment
# }