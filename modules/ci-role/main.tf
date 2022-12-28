data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  read_path_count   = can(length(var.ssm_read_paths)) ? length(var.ssm_read_paths) : 0
  write_path_count  = can(length(var.ssm_write_paths)) ? length(var.ssm_write_paths) : 0
  enable_ssm_policy = local.read_path_count == 0 && local.write_path_count == 0 ? false : true
  iam_descriptor    = format("%s_%s_%s", var.github_org, var.github_repo, var.environment_id)
  iam_policy_path   = format("/CustomerManaged/%s_%s/%s/", var.github_org, var.github_repo, var.environment_id)
}