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

variable "ci_ssm_paths" {
  description = "SSM Parameters to grant CI access to"
  type        = object({ read = list(string), write = list(string) })
  default = {
    read  = []
    write = []
  }
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
