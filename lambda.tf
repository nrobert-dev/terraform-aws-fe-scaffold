data "archive_file" "zip" {
  type        = "zip"
  source_file = "${path.module}/lambda/daily_run.py"
  output_path = "${path.module}/daily_run.zip"
}

resource "aws_lambda_function" "lambda_function" {
  depends_on    = [data.archive_file.zip]
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_role.arn
  runtime       = "python3.8"
  handler       = "daily_run.lambda_handler"

  filename = "${path.module}/daily_run.zip"

  environment {
    variables = {
      BUCKET_NAME = var.s3_bucket_name
    }
  }
}

# Create the IAM role for the Lambda function
resource "aws_iam_role" "lambda_role" {
  name               = "lambda-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "s3_write_policy" {
  name        = "lambda-write-s3-policy"
  description = "Write to S3 Policy"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "logs:*",
      "Resource": "arn:aws:logs:*:*:*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${var.s3_bucket_name}",
        "arn:aws:s3:::${var.s3_bucket_name}/*"
      ]
    }
  ]
}
EOF
}


# Attach necessary permissions to the Lambda role
resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.s3_write_policy.arn
}

# Create the CloudWatch Event rule
resource "aws_cloudwatch_event_rule" "event_rule" {
  name        = "daily-lambda-trigger"
  description = "Trigger Lambda function daily"

  schedule_expression = "rate(5 minutes)"

  tags = {
    Name = "Lambda Event Rule"
  }
}

# Add a target to the CloudWatch Event rule to invoke the Lambda function
resource "aws_cloudwatch_event_target" "event_target" {
  rule      = aws_cloudwatch_event_rule.event_rule.name
  target_id = "invoke-lambda-function"
  arn       = aws_lambda_function.lambda_function.arn
}

# Configure Lambda permission to allow CloudWatch Events to invoke the function
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowCloudWatchToInvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.event_rule.arn
}
