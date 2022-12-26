resource "aws_iam_policy" "read_write_site_bucket_cd_policy" {
  name        = format("CD_ReadWrite_S3_%s", var.site_bucket)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s objects", var.site_bucket)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/cd-read-write-site.tpl",
    {
      bucket-name = var.site_bucket
    }
  )
}

resource "aws_iam_policy" "invalidate_cloudfront_cd_policy" {
  name        = format("CD_Invalidate_Cloudfront_Distribution_%s", var.site_bucket)
  path        = "/CustomerManaged/"
  description = format("Allows invalidate on %s Cloudfront Distribution", var.site_bucket)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/cd-invalidate-cloudfront.tpl",
    {
      aws-account-id             = data.aws_caller_identity.current.account_id
      cloudfront-distribution-id = var.cloudfront_distribution_id
    }
  )
}

resource "aws_iam_role_policy_attachment" "read_write_artifacts_cd_policy_attachment" {
  role       = aws_iam_role.cd_role.name
  policy_arn = aws_iam_policy.read_write_artifacts_bucket_cicd_policy.arn
}

# resource "aws_iam_role_policy_attachment" "ssm_cd_policy_attachment" {
#   role       = aws_iam_role.cd_role.name
#   policy_arn = aws_iam_policy.ssm_cd_policy.arn
# }

resource "aws_iam_role_policy_attachment" "read_write_site_bucket_cd_policy_attachment" {
  role       = aws_iam_role.cd_role.name
  policy_arn = aws_iam_policy.read_write_site_bucket_cd_policy.arn
}

resource "aws_iam_role_policy_attachment" "invalidate_cloudfront_cd_policy_attachment" {
  role       = aws_iam_role.cd_role.name
  policy_arn = aws_iam_policy.invalidate_cloudfront_cd_policy.arn
}