data "aws_iam_policy_document" "policy_document" {
  dynamic "statement" {
    for_each = var.read
    content {
      sid = "ReadParameters"
      actions = [
        "ssm:GetParameterHistory",
        "ssm:GetParametersByPath",
        "ssm:GetParameters",
        "ssm:GetParameter"
      ]
      resources = [
        format("arn:aws:ssm:%s:%s:parameter%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, statement.value)
      ]
    }
  }

  dynamic "statement" {
    for_each = var.write
    content {
      sid = "WriteParameters"
      actions = [
        "ssm:PutParameter",
        "ssm:LabelParameterVersion",
        "ssm:DeleteParameter",
        "ssm:UnlabelParameterVersion",
        "ssm:RemoveTagsFromResource",
        "ssm:AddTagsToResource",
        "ssm:DeleteParameters"
      ]
      resources = [
        format("arn:aws:ssm:%s:%s:parameter%s", data.aws_region.current.name, data.aws_caller_identity.current.account_id, statement.value)
      ]
    }
  }
}