resource "aws_iam_policy" "read_write_temp_bucket_ci_policy" {
  name        = format("CI_ReadWrite_S3_%s", var.ci_prefix)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s* S3 buckets", var.ci_prefix)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/ci-read-write-temp.tpl",
    {
      ci-prefix = var.ci_prefix
    }
  )
}

resource "aws_iam_policy" "read_write_cloudformation_ci_policy" {
  name        = format("CI_ReadWrite_Cloudformation_%s", var.ci_prefix)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s* Cloudformation Stacks", var.ci_prefix)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/ci-temp-cloudformation.tpl",
    {
      aws-account-id = data.aws_caller_identity.current.account_id
      aws-region     = data.aws_region.current.name
      ci-prefix      = var.ci_prefix
    }
  )

}

resource "aws_iam_role_policy_attachment" "read_write_artifacts_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_artifacts_bucket_cicd_policy.arn
}

resource "aws_iam_role_policy_attachment" "ssm_ci_policy_attachment" {
  count = local.enable_ci_ssm_policy ? 1 : 0
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.ssm_ci_policy[1].arn
}

resource "aws_iam_role_policy_attachment" "read_write_temp_bucket_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_temp_bucket_ci_policy.arn
}

resource "aws_iam_role_policy_attachment" "read_write_cloudformation_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_cloudformation_ci_policy.arn
}