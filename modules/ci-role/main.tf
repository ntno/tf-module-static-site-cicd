data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# handle when optional values are null
locals {
  github_env_name_length = can(length(var.github_environment_name)) ? length(var.github_environment_name) : 0
  read_path_count        = can(length(var.ssm_read_paths)) ? length(var.ssm_read_paths) : 0
  write_path_count       = can(length(var.ssm_write_paths)) ? length(var.ssm_write_paths) : 0
}

locals {
  enable_github_env_trust_policy = local.github_env_name_length == 0 ? false : true
  enable_ssm_policy              = local.read_path_count == 0 && local.write_path_count == 0 ? false : true
  iam_descriptor                 = format("%s_%s_%s", var.github_org, var.github_repo, var.environment_id)
  iam_policy_path                = format("/CustomerManaged/%s_%s/%s/", var.github_org, var.github_repo, var.environment_id)
}