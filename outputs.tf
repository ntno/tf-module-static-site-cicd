output "ci_role" {
  description = "CI IAM Role Name and ARN"
  value       = module.ci_role.output
}

output "cd_roles" {
  description = "list of CD IAM Role name/ARN/github_environment_name"
  value       = module.cd_roles[*].output
}
