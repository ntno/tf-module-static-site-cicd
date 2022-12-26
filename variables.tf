variable "site_bucket" {
  description = "Name of the S3 bucket where the site will be deployed"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "Cloudfront distribution id to the main site.  Used to invalidate cache after site deployment"
  type        = string
}

variable "artifact_bucket_name" {
  description = "Name of S3 bucket to create for storing site artifacts.  Must be unique in S3"
  type        = string
}

variable "github_repo" {
  description = "GitHub repository for OIDC"
  type        = string
}

variable "github_org" {
  description = "GitHub organization for OIDC"
  type        = string
}

variable "ci_prefix" {
  description = "Prefix to restrict S3/Cloudformation actions"
  type        = string
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}
