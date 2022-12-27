data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  enable_ssm_policy = length(var.ssm_read_paths) == 0 && length(var.ssm_write_paths) == 0 ? false : true
  iam_descriptor    = format("%s_%s", var.github_org, var.github_repo)
  iam_policy_path   = format("/CustomerManaged/%s_%s/", var.github_org, var.github_repo)
}