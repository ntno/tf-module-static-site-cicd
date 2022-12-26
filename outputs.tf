output "ci_role_name" {
  description = "CI IAM Role Name"
  value       = aws_iam_role.ci_role.name
}

output "cd_role_name" {
  description = "CD IAM Role Name"
  value       = aws_iam_role.cd_role.name
}