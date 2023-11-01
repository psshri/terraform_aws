# SNS Topic #####################################
resource "aws_sns_topic" "sns_topic" {
  name = "lambda_sns_topic"
}

# SNS Topic Subscription ########################
resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "psshri@outlook.com"

  depends_on = [
    aws_sns_topic.sns_topic
  ]
}