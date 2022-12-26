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
  name        = format("CI_ReadWrite_SSM_%s", var.site_bucket)
  path        = "/CustomerManaged/"
  description = format("Allows read/write on %s CI SSM Parameters", var.site_bucket)
  tags        = var.tags

  policy = data.aws_iam_policy_document.ssm_ci_policy_document.json

  # templatefile("${path.module}/templates/ssm.tpl",
  #   {
  #     read-paths  = jsonencode(var.ci_ssm_paths["read"])
  #     write-paths = jsonencode(var.ci_ssm_paths["write"])
  #   }
  # )
}


data "aws_iam_policy_document" "ssm_ci_policy_document" {
  dynamic "statement" {
    for_each = var.ci_ssm_paths["read"]
    content {
      sid = "ReadParameters"
      actions = [
        "ssm:GetParameterHistory",
        "ssm:GetParametersByPath",
        "ssm:GetParameters",
        "ssm:GetParameter"
      ]
      resources = [
        format("arn:aws:ssm:%s:%s:parameter/%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, "${each.value}")
      ]
    }
  }
}


# resource "aws_iam_policy" "ssm_cd_policy" {
#   name        = format("CD_ReadWrite_SSM_%s", var.site_bucket)
#   path        = "/CustomerManaged/"
#   description = format("Allows read/write on %s CD SSM Parameters", var.site_bucket)
#   tags        = var.tags

#   policy = templatefile("${path.module}/templates/ssm.tpl",
#     {
#       read-paths  = jsonencode(var.cd_ssm_paths["read"])
#       write-paths = jsonencode(var.cd_ssm_paths["write"])
#     }
#   )
# }

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