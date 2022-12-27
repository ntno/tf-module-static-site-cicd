output "ci_role" {
  description = "CI IAM Role Name and ARN"
  value = {
    iam_role_name = module.ci_role.role_name
    iam_role_arn  = module.ci_role.role_arn
  }
}

output "cd_roles" {
  description = "list of CD IAM Role name/ARN/github_environment_name"
  value       = module.cd_roles[*].role_arn
}
