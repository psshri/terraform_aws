data "aws_iam_policy_document" "topic" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["s3.amazonaws.com"]
    }

    actions   = ["SNS:Publish"]
    resources = ["arn:aws:sns:*:*:lambda_sns_topic"]

    condition {
      test     = "ArnLike"
      variable = "aws:SourceArn"
      values   = [aws_s3_bucket.s3_bucket.arn]
    }
  }
}

# SNS Topic #####################################
resource "aws_sns_topic" "sns_topic" {
  name = "lambda_sns_topic"
  policy = data.aws_iam_policy_document.topic.json
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