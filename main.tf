data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  iam_policy_path = format("/CustomerManaged/%s_%s/", var.github_org, var.github_repo)
}
