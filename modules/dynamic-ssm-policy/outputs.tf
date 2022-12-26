output "policy_arn" {
  description = "IAM Policy ARN"
  value       = aws_iam_policy.ssm_policy.arn
}