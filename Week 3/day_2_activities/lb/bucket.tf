resource "aws_s3_bucket" "alb_logs" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = var.bucket_name
  policy = data.aws_iam_policy_document.allow_s3_access.json
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {
    principals {
      type = "AWS"
      identifiers = [ "138588690193" ]
    }

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject"
    ]

    resources = [
      aws_s3_bucket.alb_logs.arn,
      "${aws_s3_bucket.alb_logs.arn}/*"
    ]
  }
}

