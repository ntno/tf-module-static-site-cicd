output "role_name" {
  description = "IAM Role Name"
  value       = aws_iam_role.iam_role.name
}

output "role_arn" {
  description = "IAM Role ARN"
  value       = aws_iam_role.iam_role.arn
}

output "ci_prefix" {
  description = "S3/Cloudformation prefix restriction"
  value       = var.ci_prefix
}