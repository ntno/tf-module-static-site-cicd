module "ssm_policy_attachment" {
  count  = local.enable_ssm_policy ? 1 : 0
  source = "./dynamic-ssm-policy"

  policy_name        = format("CI_ReadWrite_SSM_%s", local.iam_descriptor)
  policy_description = format("Allows read/write on %s SSM Parameters", local.iam_descriptor)
  policy_path = local.iam_policy_path
  read               = var.ssm_read_paths
  write              = var.ssm_write_paths
  role_name          = aws_iam_role.iam_role.name
  tags               = var.tags
}



resource "aws_iam_role_policy_attachment" "read_write_artifacts_policy_attachment" {
  role       = aws_iam_role.iam_role.name
  policy_arn = var.read_write_artifact_bucket_policy_arn
}

