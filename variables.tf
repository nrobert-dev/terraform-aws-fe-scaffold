variable "aws_region" {
  description = "Region of AWS"
  type        = string
}

variable "s3_bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
}

variable "website_tag" {
  description = "The tag the S3 Bucket will use for the website"
  type        = string
  default     = "Hosted Website"
}

variable "lambda_function_name" {
  description = "Name for the lambda function"
  type        = string
  default     = "daily-lambda-function"
}
