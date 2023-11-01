# IAM Role ######################################
resource "aws_iam_role" "lambda_role" {
    name = "lambda_role"
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
    policy = <<EOF
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
    role = "${aws_iam_role.lambda_role.id}"
    policy_arn = "${aws_iam_policy.s3_policy.arn}"

    depends_on = [
        aws_iam_role.lambda_role,
        aws_iam_policy.s3_policy
    ]
}

# Zip the file
data "archive_file" "python_code_zip" {
type        = "zip"
source_dir  = "${path.module}/python/"
output_path = "${path.module}/python/hello-python.zip"
}