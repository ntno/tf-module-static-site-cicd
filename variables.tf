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
  type = object({
    github_environment_name = string
    ci_prefix               = string
    ssm_read_paths          = optional(list(string))
    ssm_write_paths         = optional(list(string))
    tags                    = optional(map(string))
  })
}

variable "deployment_environments" {
  type = map(
    object({
      github_environment_name    = string
      deploy_bucket              = string
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
