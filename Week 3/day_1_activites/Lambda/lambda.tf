resource "aws_iam_role" "lambda_exec" {
  name = "lambda-role-rory"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    policy = data.aws_iam_policy_document.inline_policy.json
  }
}

resource "aws_iam_policy" "lambda_inline_policy" {
  name = "lambda-s3-inline-policy-rory"
  policy = data.aws_iam_policy_document.inline_policy.json
}

data "aws_iam_policy_document" "root_policy" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

  }
}


data "aws_iam_policy_document" "inline_policy" {
 statement {
    actions   = [
        "logs:PutLogEvents",
        "logs:CreateLogStream",
        "logs:CreateLogGroup"
    ]
    resources = ["arn:aws:logs:*:*:*"]
    effect = "Allow"
  }
  statement {
    actions   = ["s3:GetObject"]
    resources = ["arn:aws:s3:::*/*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name = "policy-attachment-rory"
  policy_arn = aws_iam_policy.lambda_inline_policy.arn
  roles = [aws_iam_role.lambda_exec.name]
}

data "archive_file" "lambda" {
  type        = "zip"
  source_file = "/Users/roryloughrey/Documents/Academy_Training/PlatformsAcademy/Week 3/day_1_activites/Lambda/lambda.js"
  output_path = "lambda_function_payload.zip"
}

resource "aws_s3_object" "lambda_code" {
  bucket = var.bucket_name

  key    = "js-code.zip"
  source = data.archive_file.lambda.output_path

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(data.archive_file.lambda.output_path)

  depends_on = [aws_s3_bucket.root-bucket]
}

resource "aws_lambda_function" "function" {
  function_name = "s3-logging-rory"

  s3_bucket = aws_s3_bucket.root-bucket.id
  s3_key    = aws_s3_object.lambda_code.key

  runtime = "nodejs16.x"
  handler = "lambda.handler"

  source_code_hash = data.archive_file.lambda.output_path

  role = aws_iam_role.lambda_exec.arn

  depends_on = [ aws_iam_role.lambda_exec ]
}

