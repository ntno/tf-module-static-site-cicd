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

variable "deployment_environments" {
  type = list(object(
    {
      env_name                   = string
      github_environment_name    = string
      deploy_bucket              = string
      cloudfront_distribution_id = optional(string)
      ssm_read_paths             = optional(list(string))
      ssm_write_paths            = optional(list(string))
      tags                       = optional(map(string))
    }
  ))
  default = [
    {
      env_name                = "production"
      github_environment_name = "prod"
      deploy_bucket           = "factually-settled-boxer"
    },
    {
      env_name                = "development"
      github_environment_name = "ci"
      deploy_bucket           = "dev.factually-settled-boxer"
    }
  ]
}

variable "tags" {
  description = "Tags to set"
  type        = map(string)
  default     = {}
}
