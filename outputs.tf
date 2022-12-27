output "artifacts_bucket_name" {
  description = "S3 artifacts bucket name"
  value       = aws_s3_bucket.artifacts_bucket.id
}

output "ci_role" {
  description = "CI IAM Role Name and ARN"
  value = {
    iam_role_name = module.ci_role.role_name
    iam_role_arn  = module.ci_role.role_arn
  }
}

output "cd_roles" {
  description = "CD IAM Role name/ARN/github_environment_name"
  value = {
    for key, val in module.cd_roles : key => {
      iam_role_name           = val.role_name
      iam_role_arn            = val.role_arn
      github_environment_name = val.github_environment_name
    }
  }
}