output "ci_role" {
  description = "CI IAM Role Name and ARN"
  value = {
    iam_role_name = module.ci_role.role_name
    iam_role_arn  = module.ci_role.role_arn
  }
}

output "cd_roles" {
  description = "list of CD IAM Role name/ARN/github_environment_name"
  value = {
    for key, val in module.cd_roles : key => {
      iam_role_name = val.role_name
      iam_role_arn  = val.role_arn
    }
  }

  #  {for key,val in var.my_network : key => val if val.name != "" && val.cidr != ""}
  # value       = tomap(
  #   for e in module.cd_roles : e.github_environment_name => {
  #     iam_role_name = e.role_name
  #     iam_role_arn = e.role_arn
  #   }
  # )
}