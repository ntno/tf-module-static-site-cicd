data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  enable_ci_ssm_policy = length(var.ci_ssm_paths["read"]) == 0 && length(var.ci_ssm_paths["write"]) == 0 ? false : true
  enable_cd_ssm_policy = length(var.cd_ssm_paths["read"]) == 0 && length(var.cd_ssm_paths["write"]) == 0 ? false : true
}

#  can(var.cloudfront_distribution_id) ? true : false