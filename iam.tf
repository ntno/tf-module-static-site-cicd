resource "aws_iam_policy" "read_write_artifacts_bucket_cicd_policy" {
  name        = format("CICD_ReadWrite_S3_%s", var.artifact_bucket_name)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s objects", var.artifact_bucket_name)
  tags        = var.tags

  policy = templatefile("${path.module}/templates/cicd-read-write-artifacts.tpl",
    {
      bucket-name = var.artifact_bucket_name
    }
  )
}

resource "aws_iam_policy" "ssm_ci_policy" {
  count       = local.enable_ci_ssm_policy ? 1 : 0
  name        = format("CI_ReadWrite_SSM_%s", var.site_bucket)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s CI SSM Parameters", var.site_bucket)
  tags        = var.tags

  policy = module.ssm_ci_policy_document[1].policy_json
}

module "ssm_ci_policy_document" {
  count       = local.enable_ci_ssm_policy ? 1 : 0
  source = "./modules/dynamic-ssm-policy"
  read   = var.ci_ssm_paths["read"]
  write  = var.ci_ssm_paths["write"]
}

resource "aws_iam_policy" "ssm_cd_policy" {
  count       = local.enable_cd_ssm_policy ? 1 : 0
  name        = format("CD_ReadWrite_SSM_%s", var.site_bucket)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s CD SSM Parameters", var.site_bucket)
  tags        = var.tags

  policy = module.ssm_cd_policy_document[1].policy_json
}

module "ssm_cd_policy_document" {
  count  = local.enable_cd_ssm_policy ? 1 : 0
  source = "./modules/dynamic-ssm-policy"
  read   = var.cd_ssm_paths["read"]
  write  = var.cd_ssm_paths["write"]
}

resource "aws_iam_role" "ci_role" {
  name = format("CI-%s", var.site_bucket)
  tags = var.tags
  assume_role_policy = templatefile("${path.module}/templates/cicd-github-trust-policy.tpl",
    {
      github-repo = var.github_repo
      github-org  = var.github_org
    }
  )
}

resource "aws_iam_role" "cd_role" {
  name = format("CD-%s", var.site_bucket)
  tags = var.tags
  assume_role_policy = templatefile("${path.module}/templates/cicd-github-trust-policy.tpl",
    {
      github-repo = var.github_repo
      github-org  = var.github_org
    }
  )
}