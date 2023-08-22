resource "aws_iam_role" "alb_s3_role" {
  name = "alb-role-rory"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  inline_policy {
    policy = data.aws_iam_policy_document.inline_policy.json
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
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::*/*"]
    effect = "Allow"
  }
}

resource "aws_iam_policy" "alb_inline_policy" {
  name = "lambda-s3-inline-policy-rory"
  policy = data.aws_iam_policy_document.inline_policy.json
}

resource "aws_iam_policy_attachment" "alb_iam_attach" {
  name = "policy-attachment-rory"
  roles       = [aws_iam_role.alb_s3_role.name]
  policy_arn = aws_iam_policy.alb_inline_policy.arn
}


