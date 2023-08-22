resource "aws_s3_bucket" "root-bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = var.bucket_name
    Environment = "Dev"
  }
}

resource "aws_s3_object" "object" {
  bucket = var.bucket_name
  key    = "example-upload"
  source = var.bucket_payload

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5(var.bucket_payload)


  depends_on = [aws_s3_bucket.root-bucket]

}