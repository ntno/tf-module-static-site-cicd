variable "domain_name" {
  description = "Domain name.  Must be owned by the AWS account.  Must be unique in S3"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "Cloudfront distribution id to the main site.  Used to invalidate cache after site deployment"
  type        = string
}

variable "artifact_bucket_name" {
  description = "CI/CD bucket for storing site artifacts.  Must be unique in S3"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository for OIDC"
  type = string
}

variable "github_org" {
  description = "GitHub organization for OIDC"
  type = string
}

variable "ci_prefix" {
  description = "Prefix to restrict S3/Cloudformation actions"
  type        = string
}

variable "tags" {
  description = "Tags to set on the bucket."
  type        = map(string)
  default     = {}
}
