variable "read_write_artifact_bucket_policy_arn" {
  description = "IAM Policy ARN granting read/write access to artifact bucket"
  type        = string
}

variable "environment_id" {
  description = "Project unique ID used to manage named IAM policies"
  type        = string
}

variable "github_environment_name" {
  description = "Used to sets the IAM trust policy on the deployment role.  Prevents use of the IAM role with any other GitHub environment"
  type        = string
}

variable "deploy_bucket" {
  description = "Name of the S3 bucket where the site will be deployed"
  type        = string
}

variable "cloudfront_distribution_id" {
  description = "Cloudfront distribution id for the site.  Used to invalidate cache after site deployment"
  type        = string
  default     = ""
}

variable "ssm_read_paths" {
  description = "SSM Parameters to grant read access to"
  type        = list(string)
  default     = []
}

variable "ssm_write_paths" {
  description = "SSM Parameters to grant write access to"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}

variable "github_repo" {
  description = "GitHub repository for OIDC"
  type        = string
}

variable "github_org" {
  description = "GitHub organization for OIDC"
  type        = string
}