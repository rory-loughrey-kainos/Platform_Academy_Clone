resource "aws_s3_bucket" "terraform_state" {
  bucket = local.bucket_name

  # lifecycle {
  #   prevent_destroy = true
  # }

  tags = merge(
    local.default_tags,
    tomap({ "Name" = local.bucket_name })
  )
}