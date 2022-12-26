output "ci_role_name" {
  description = "CI IAM Role Name"
  value       = aws_iam_role.ci_role.name
}

output "cd_role_name" {
  description = "CD IAM Role Name"
  value       = aws_iam_role.cd_role.name
}

output "ci_role_arn" {
  description = "CI IAM Role ARN"
  value       = aws_iam_role.ci_role.arn
}

output "cd_role_arn" {
  description = "CD IAM Role ARN"
  value       = aws_iam_role.cd_role.arn
}