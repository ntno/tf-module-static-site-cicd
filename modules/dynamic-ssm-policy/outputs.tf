output "policy_json" {
  description = "generated JSON policy document"
  value       = data.aws_iam_policy_document.policy_document.json
}