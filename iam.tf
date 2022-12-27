resource "aws_iam_policy" "read_write_artifacts_bucket_cicd_policy" {
  path        = local.iam_policy_path
  name        = format("CICD_ReadWrite_S3_%s", var.artifact_bucket_name)
  description = format("Allows read/write on %s objects", var.artifact_bucket_name)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/cicd-read-write-artifacts.tpl",
    {
      bucket-name = var.artifact_bucket_name
    }
  )
}

module "ci_role" {
  source                                = "./modules/ci-role"
  read_write_artifact_bucket_policy_arn = aws_iam_policy.read_write_artifacts_bucket_cicd_policy.arn
  ci_prefix                             = var.ci_prefix
  ssm_read_paths                        = var.ci_ssm_paths["read"]
  ssm_write_paths                       = var.ci_ssm_paths["write"]
  github_org                            = var.github_org
  github_repo                           = var.github_repo
  tags                                  = var.tags
}