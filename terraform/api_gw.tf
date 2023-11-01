# API GW
resource "aws_apigatewayv2_api" "http_api" {
  name          = "http_api"
  protocol_type = "HTTP"
}

# Lambda Integration
resource "aws_apigatewayv2_integration" "http_api_integration" {
  api_id           = aws_apigatewayv2_api.http_api.id
  integration_type = "AWS_PROXY"

  connection_type    = "INTERNET"
  integration_method = "POST"
  integration_uri    = aws_lambda_function.lambda_function.invoke_arn

  depends_on = [
    aws_apigatewayv2_api.http_api,
    aws_lambda_function.lambda_function
  ]
}

# Route
resource "aws_apigatewayv2_route" "http_api_route" {
  api_id    = aws_apigatewayv2_api.http_api.id
  route_key = "POST /path"

  target = "integrations/${aws_apigatewayv2_integration.http_api_integration.id}"

  authorization_type = "NONE"

  depends_on = [
    aws_apigatewayv2_api.http_api,
    aws_apigatewayv2_integration.http_api_integration
  ]
}

# Deployment
resource "aws_apigatewayv2_deployment" "http_api_deployment" {
  api_id      = aws_apigatewayv2_api.http_api.id

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_apigatewayv2_api.http_api,
    aws_apigatewayv2_route.http_api_route
  ]
}

# Stage
resource "aws_apigatewayv2_stage" "http_api_stage" {
  api_id = aws_apigatewayv2_api.http_api.id
  name   = "dev"
  auto_deploy = true

  depends_on = [
    aws_apigatewayv2_api.http_api
  ]
}


resource "aws_lambda_permission" "apigw_lambda" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.http_api.execution_arn}/*/*/*"

  depends_on = [
    aws_lambda_function.lambda_function,
    aws_apigatewayv2_api.http_api
  ]
}
