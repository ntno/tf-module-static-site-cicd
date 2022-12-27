module "ssm_policy_attachment" {
  count  = local.enable_ssm_policy ? 1 : 0
  source = "./dynamic-ssm-policy"

  policy_name        = format("CD_ReadWrite_SSM_%s", local.iam_descriptor)
  policy_description = format("Allows read/write on %s SSM Parameters", local.iam_descriptor)
  policy_path = local.iam_policy_path
  read               = var.ssm_read_paths
  write              = var.ssm_write_paths
  role_name          = aws_iam_role.iam_role.name
  tags               = var.tags
}

resource "aws_iam_policy" "read_write_site_bucket_policy" {
  path        = local.iam_policy_path
  name        = format("CD_ReadWrite_S3_%s", local.iam_descriptor)
  description = format("Allows read/write on %s objects", local.iam_descriptor)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/read-write-site.tpl",
    {
      bucket-name = var.deploy_bucket
    }
  )
}

resource "aws_iam_policy" "invalidate_cloudfront_policy" {
  count       = local.enable_cloudfront_policy ? 1 : 0
  path        = local.iam_policy_path
  name        = format("CD_Invalidate_Cloudfront_%s", local.iam_descriptor)
  description = format("Allows invalidate on %s Cloudfront Distribution", local.iam_descriptor)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/invalidate-cloudfront.tpl",
    {
      aws-account-id             = data.aws_caller_identity.current.account_id
      cloudfront-distribution-id = var.cloudfront_distribution_id
    }
  )
}

resource "aws_iam_role_policy_attachment" "read_write_artifacts_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = var.read_write_artifact_bucket_policy_arn
}

resource "aws_iam_role_policy_attachment" "read_write_site_bucket_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.read_write_site_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "invalidate_cloudfront_policy_attachment" {
  count      = local.enable_cloudfront_policy ? 1 : 0
  role       = aws_iam_role.iam_role.name
  policy_arn = aws_iam_policy.invalidate_cloudfront_policy[0].arn
}