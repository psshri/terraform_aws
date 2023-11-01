# IAM Role ######################################
resource "aws_iam_role" "lambda_role" {
  name               = "lambda_role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# IAM Policy ####################################
resource "aws_iam_policy" "s3_sns_policy" {
  name        = "s3_sns_policy"
  description = "s3_get_put_policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "s3:PutObject",
            "s3:GetObject",
            "sns:Publish"
        ],
        "Effect": "Allow",
        "Resource": [
          "${aws_s3_bucket.s3_bucket.arn}/*",
          "${aws_sns_topic.sns_topic.arn}"
        ]
    }
  ]
}
EOF

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]

}

# LambdaBasicExecutionRole
resource "aws_iam_role_policy_attachment" "lambda_basic" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  role = aws_iam_role.lambda_role.name

  depends_on = [
    aws_iam_role.lambda_role
  ]
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_s3_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.s3_sns_policy.arn

  depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_policy.s3_sns_policy
  ]
}

# Zip the file
data "archive_file" "python_code_zip" {
  type        = "zip"
  source_file = "${path.module}/python/index.py"
  output_path = "${path.module}/python/hello-python.zip"
}

# Lambda Function
resource "aws_lambda_function" "lambda_function" {
  filename      = "${path.module}/python/hello-python.zip"
  function_name = "test_lambda_function"
  role          = aws_iam_role.lambda_role.arn
  handler       = "index.lambda_handler"
  runtime       = "python3.11"
  source_code_hash = data.archive_file.python_code_zip.output_base64sha256

  environment {
    variables = {
      S3_BUCKET_NAME = "bar"
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.lambda_s3_role_policy_attachment,
  ]
}