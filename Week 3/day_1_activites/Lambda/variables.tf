variable "bucket_payload" {
  type        = string
  default     = "/Users/roryloughrey/Documents/Academy_Training/PlatformsAcademy/Week 3/Day 1 - AWS Overview.md"
  description = "path to object to push to bucket"
}

variable "bucket_name" {
  type        = string
  default     = "s3-upload-rory"
  description = "name of bucket"
}