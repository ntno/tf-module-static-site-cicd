module "ssm_policy_attachment" {
  count  = local.enable_ssm_policy ? 1 : 0
  source = "../dynamic-ssm-policy"

  policy_name        = format("CI_ReadWrite_SSM_%s", local.iam_descriptor)
  policy_description = format("Allows read/write on %s SSM Parameters", local.iam_descriptor)
  policy_path        = local.iam_policy_path
  read               = var.ssm_read_paths
  write              = var.ssm_write_paths
  role_name          = aws_iam_role.iam_role.name
  tags               = var.tags
}

resource "aws_iam_policy" "read_write_temp_site_bucket_policy" {
  path        = local.iam_policy_path
  name        = format("CI_ReadWrite_S3_%s", var.ci_prefix)
  description = format("Allows read/write on %s* S3 buckets", var.ci_prefix)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/read-write-temp-site.tpl",
    {
      ci-prefix = var.ci_prefix
    }
  )
}

resource "aws_iam_policy" "manage_temp_cloudformation_policy" {
  path        = local.iam_policy_path
  name        = format("CI_Manage_Cloudformation_%s", var.ci_prefix)
  description = format("Allows create/delete on %s* Cloudformation Stacks", var.ci_prefix)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/manage-temp-cloudformation-stacks.tpl",
    {
      aws-account-id = data.aws_caller_identity.current.account_id
      aws-region     = data.aws_region.current.name
      ci-prefix      = var.ci_prefix
    }
  )
}

resource "aws_iam_role_policy_attachment" "read_write_artifacts_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = var.read_write_artifact_bucket_policy_arn
}

resource "aws_iam_role_policy_attachment" "read_write_temp_site_bucket_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.read_write_temp_site_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "manage_temp_cloudformation_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.manage_temp_cloudformation_policy.arn
}