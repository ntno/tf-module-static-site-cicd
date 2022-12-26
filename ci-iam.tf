

resource "aws_iam_policy" "read_write_site_bucket_ci_policy" {
  name        = format("ReadWrite_CI_%s_S3", var.ci_prefix)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s S3 buckets for CI", var.ci_prefix)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/read-write-ci-bucket.tpl",
    {
      ci-prefix = var.ci_prefix
    }
  )
}

resource "aws_iam_policy" "read_write_cloudformation_stack_ci_policy" {
  name        = format("ReadWrite_%s_CloudformationStack", var.ci_prefix)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s Cloudformation Stacks", var.ci_prefix)
  tags        = var.tags
  
  policy = templatefile("${path.module}/templates/read-write-cloudformation-ci-stack.tpl",
    {
      aws-account-id = data.aws_caller_identity.current.account_id
      ci-prefix = var.ci_prefix
    }
  )
  
}



resource "aws_iam_user_policy_attachment" "read_write_artifacts_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_artifacts_bucket_cicd_policy.arn
}

resource "aws_iam_user_policy_attachment" "read_write_site_bucket_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_site_bucket_ci_policy.arn
}

resource "aws_iam_user_policy_attachment" "read_write_cloudformation_stack_ci_policy_attachment" {
  role       = aws_iam_role.ci_role.name
  policy_arn = aws_iam_policy.read_write_cloudformation_stack_ci_policy.arn
}