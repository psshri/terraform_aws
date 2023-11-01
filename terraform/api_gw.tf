resource "aws_apigatewayv2_api" "http_api" {
  name          = "http_api"
  protocol_type = "HTTP"
}

# resource "aws_apigatewayv2_deployment" "http_api_deployment" {
#   api_id      = aws_apigatewayv2_api.http_api.id

#   lifecycle {
#     create_before_destroy = true
#   }

#   depends_on = [
#     aws_apigatewayv2_api.http_api
#   ]
# }

# Lambda Integration
resource "aws_apigatewayv2_integration" "http_api_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_function.invoke_arn
}