output "website_url" {
  description = "URL to access the website"
  value       = aws_s3_bucket_website_configuration.website_config.website_endpoint
}

output "caller" {
  description = "Caller information"
  value       = data.aws_caller_identity.current_account
}
