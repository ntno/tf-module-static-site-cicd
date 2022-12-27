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

variable "github_cd_environment_name" {
  description = "GitHub environment name to restrict Continuous Deployment IAM Role to"
  type        = string
}

variable "ci_prefix" {
  description = "Prefix to restrict S3/Cloudformation actions"
  type        = string
}

variable "ci_role_name" {
  description = "Continuous Integration IAM Role name"
  type        = string
}

variable "cd_role_name" {
  description = "Continuous Deployment IAM Role name"
  type        = string
}

variable "ci_ssm_paths" {
  description = "SSM Parameters to grant CI access to"
  type        = object({ read = list(string), write = list(string) })
  default = {
    read  = []
    write = []
  }
}

variable "cd_ssm_paths" {
  description = "SSM Parameters to grant CD access to"
  type        = object({ read = list(string), write = list(string) })
  default = {
    read  = []
    write = []
  }
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}
