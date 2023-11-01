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
resource "aws_iam_policy" "s3_policy" {
  name        = "s3_policy"
  description = "s3_get_put_policy"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
        "Action": [
            "s3:PutObject",
            "s3:GetObject"
        ],
        "Effect": "Allow",
        "Resource": "${aws_s3_bucket.s3_bucket.arn}/*"
    }
  ]
}
EOF

  depends_on = [
    aws_s3_bucket.s3_bucket
  ]

}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "lambda_s3_role_policy_attachment" {
  role       = aws_iam_role.lambda_role.id
  policy_arn = aws_iam_policy.s3_policy.arn

  depends_on = [
    aws_iam_role.lambda_role,
    aws_iam_policy.s3_policy
  ]
}

# Zip the file
data "archive_file" "python_code_zip" {
  type        = "zip"
  source_file = "${path.module}/python/index.py"
  output_path = "${path.module}/python/hello-python.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = "${path.module}/python/hello-python.zip"
  function_name    = "test_lambda_function"
  role             = aws_iam_role.lambda_role.arn
  handler          = "index.lambda_handler"
  runtime          = "python3.11"
  source_code_hash = data.archive_file.python_code_zip.output_base64sha256

  depends_on = [
    aws_iam_role_policy_attachment.lambda_s3_role_policy_attachment,
  ]
}

# resource "aws_lambda_function" "s3" {
#   function_name = "s3"
#   s3_bucket = aws_s3_bucket.lambda_bucket.id
#   s3_key    = aws_s3_object.lambda_s3.key
#   runtime = "nodejs16.x"
#   handler = "function.handler"
#   source_code_hash = data.archive_file.lambda_s3.output_base64sha256
#   role = aws_iam_role.s3_lambda_exec.arn
# }

# resource "aws_lambda_function" "test_lambda" {
#   filename      = "lambda_function_payload.zip"
#   function_name = "lambda_function_name"
#   role          = aws_iam_role.iam_for_lambda.arn
#   handler       = "index.test"
#   source_code_hash = data.archive_file.lambda.output_base64sha256
#   runtime = "nodejs18.x"
#   environment {
#     variables = {
#       foo = "bar"
#     }
#   }
# }