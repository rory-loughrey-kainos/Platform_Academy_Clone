resource "aws_s3_bucket" "alb_logs" {
  bucket = var.bucket_name
  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_public_access_block" "s3_access_pub" {

  bucket = aws_s3_bucket.alb_logs.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false

}

resource "aws_s3_bucket_ownership_controls" "s3_ownership" {
  bucket = aws_s3_bucket.alb_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "se_acl" {
  depends_on = [
    aws_s3_bucket_public_access_block.s3_access_pub,
    aws_s3_bucket_ownership_controls.s3_ownership,
  ]

  bucket = aws_s3_bucket.alb_logs.id
  acl    = "log-delivery-write"
}

resource "aws_s3_bucket_policy" "s3_policy" {
  bucket = aws_s3_bucket.alb_logs.id
  policy = data.aws_iam_policy_document.allow_s3_access.json
}

data "aws_iam_policy_document" "allow_s3_access" {
  statement {

    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["156460612806"]
    }
    actions = [
      "s3:*"
    ]
    resources = [
      aws_s3_bucket.alb_logs.arn
    ]
  }
}

