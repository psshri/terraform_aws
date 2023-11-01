resource "aws_sns_topic" "sns_topic" {
  name = "lambda_sns_topic"
}

resource "aws_sns_topic_subscription" "sns_topic_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = "psshri@outlook.com"
}