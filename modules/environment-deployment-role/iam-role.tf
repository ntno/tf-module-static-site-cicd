locals {
  policy_template = local.enable_github_env_trust_policy ? "env-specific-trust-policy.tftpl" : "any-branch-trust-policy.tftpl"
}

resource "aws_iam_role" "iam_role" {
  name = format("CD_%s", local.iam_descriptor)
  tags = var.tags
  assume_role_policy = templatefile("${path.module}/templates/${local.policy_template}",
    {
      aws-account-id     = data.aws_caller_identity.current.account_id
      github-repo        = var.github_repo
      github-org         = var.github_org
      github-environment = var.github_environment_name
    }
  )
}