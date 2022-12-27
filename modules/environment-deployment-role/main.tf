data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  enable_ssm_policy                  = length(var.ssm_read_paths) == 0 && length(var.ssm_write_paths) == 0 ? false : true
  enable_cloudfront_policy           = length(var.cloudfront_distribution_id) == 0 ? false : true
  iam_descriptor                     = format("%s_%s_%s", var.github_org, var.github_repo, var.github_environment_name)
  iam_policy_path                    = format("/CustomerManaged/%s_%s/%s/", var.github_org, var.github_repo, var.github_environment_name)
}