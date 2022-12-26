variable "domain_name" {
  description = "Domain name.  Must be owned by the AWS account.  Must be unique in S3"
  type        = string
}

variable "artifact_bucket_name" {
  description = "CI/CD bucket for storing site artifacts.  Must be unique in S3"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
