data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# handle when optional values are null
locals {
  read_path_count  = can(length(var.read)) ? length(var.read) : 0
  write_path_count = can(length(var.write)) ? length(var.write) : 0
}

data "aws_iam_policy_document" "ssm_policy_document" {
  dynamic "statement" {
    for_each = local.read_path_count == 0 ? [] : var.read
    content {
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
    for_each = local.write_path_count == 0 ? [] : var.write
    content {
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

resource "aws_iam_policy" "ssm_policy" {
  name        = var.policy_name
  path        = var.policy_path
  description = var.policy_description
  tags        = var.tags

  policy = data.aws_iam_policy_document.ssm_policy_document.json
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  role       = var.role_name
  policy_arn = aws_iam_policy.ssm_policy.arn
}