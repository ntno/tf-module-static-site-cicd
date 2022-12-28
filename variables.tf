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

variable "integration_environment" {
  description = <<-EOT
  Configuration for Continuous Integration IAM Role.  Map containing:
  Required Keys:
    environment_id           = a project unique environment ID
    ci_prefix                = prefix to restrict S3/Cloudformation IAM policies
  Optional Keys:
    github_environment_name  = if provided, used to restrict role assumption
    ssm_read_paths           = SSM Parameters paths to grant read access to
    ssm_write_paths          = SSM Parameters paths to grant write access to
    tags                     = additional tags (merged with var.tags)
  EOT
  type = object({
    environment_id          = string
    ci_prefix               = string
    github_environment_name = optional(string)
    ssm_read_paths          = optional(list(string))
    ssm_write_paths         = optional(list(string))
    tags                    = optional(map(string))
  })
}

variable "deployment_environments" {
  description = <<-EOT
  Configuration for Continuous Deployment IAM Roles.  Map of Maps where
  outer key is a project unique environment ID and each internal contains:
  Required Keys:
    deploy_bucket               = name of the S3 bucket where the site will be deployed
  Optional Keys:
    github_environment_name     = if provided, used to restrict role assumption
    cloudfront_distribution_id  = if provided, used to create cloudfront cache invalidate IAM policy
    ssm_read_paths              = SSM Parameters paths to grant read access to
    ssm_write_paths             = SSM Parameters paths to grant write access to
    tags                        = additional tags (merged with var.tags)
  EOT
  type = map(
    object({
      deploy_bucket              = string
      github_environment_name    = optional(string)
      cloudfront_distribution_id = optional(string)
      ssm_read_paths             = optional(list(string))
      ssm_write_paths            = optional(list(string))
      tags                       = optional(map(string))
    })
  )
  default = {}
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}
