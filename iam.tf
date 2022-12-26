
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

resource "aws_iam_role" "ci_role" {
  name = format("%s-CI", var.site_bucket)
  tags = var.tags
  assume_role_policy = templatefile("${path.module}/templates/cicd-github-trust-policy.tpl",
    {
      github-repo = var.github_repo
      github-org  = var.github_org
    }
  )
}

resource "aws_iam_role" "cd_role" {
  name = format("%s-CD", var.site_bucket)
  tags = var.tags
  assume_role_policy = templatefile("${path.module}/templates/cicd-github-trust-policy.tpl",
    {
      github-repo = var.github_repo
      github-org  = var.github_org
    }
  )
}

