output "artifacts_bucket_info" {
  description = "Map containing the artifacts bucket's arn and id"
  value = {
    arn = aws_s3_bucket.artifacts_bucket.arn
    id  = aws_s3_bucket.artifacts_bucket.id
  }
}

output "ci_role_info" {
  description = "Environment ID to Map containing the CI IAM Role's arn, name, S3/Cloudformation prefix restriction, and associated github_environment_name"
  value = tomap({
    (module.ci_role.environment_id) = tomap({
      arn                     = module.ci_role.role_arn,
      name                    = module.ci_role.role_name,
      ci_prefix               = module.ci_role.ci_prefix,
      github_environment_name = module.ci_role.github_environment_name
    })
  })
}

output "cd_role_info" {
  description = "Environment ID to Map containing CD IAM Role's arn, name, and associated github_environment_name"
  value = {
    for key, val in module.cd_roles : key => {
      arn                     = val.role_arn
      name                    = val.role_name
      github_environment_name = val.github_environment_name
    }
  }
}