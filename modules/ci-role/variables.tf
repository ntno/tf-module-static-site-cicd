variable "read_write_artifact_bucket_policy_arn" {
  description = "IAM Policy ARN granting read/write access to artifact bucket"
  type        = string
}

variable "ci_prefix" {
  description = "Prefix to restrict S3/Cloudformation actions"
  type        = string
}

variable "environment_id" {
  description = "Project unique ID used to manage named IAM policies"
  type        = string
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

variable "github_environment_name" {
  description = "If provided, used to restrict OIDC role assumption.  Prevents use of the IAM role with any other GitHub environment"
  type        = string
  default     = ""
}