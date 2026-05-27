data "aws_iam_policy_document" "assume_role" {
  for_each = var.roles

  statement {
    effect  = "Allow"
    actions = each.value.trust_policy.actions

    dynamic "principals" {
      for_each = each.value.trust_policy.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }

    dynamic "condition" {
      for_each = each.value.trust_policy.conditions
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_iam_role" "main" {
  for_each = var.roles

  name                 = each.key
  description          = each.value.description
  assume_role_policy   = data.aws_iam_policy_document.assume_role[each.key].json
  max_session_duration = each.value.max_session_duration
  tags                 = each.value.tags
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = {
    for pair in flatten([
      for role_name, role in var.roles : [
        for arn in role.managed_policy_arns : {
          role_name  = role_name
          policy_arn = arn
        }
      ]
    ]) : "${pair.role_name}__${pair.policy_arn}" => pair
  }

  role       = aws_iam_role.main[each.value.role_name].name
  policy_arn = each.value.policy_arn
}

data "aws_iam_policy_document" "inline" {
  for_each = {
    for role_name, role in var.roles : role_name => role
    if length(role.inline_policy_statements) > 0
  }

  dynamic "statement" {
    for_each = { for idx, stmt in each.value.inline_policy_statements : idx => stmt }
    content {
      sid       = statement.value.sid != null ? statement.value.sid : "${each.key}InlinePolicy${statement.key}"
      effect    = statement.value.effect
      actions   = statement.value.actions
      resources = statement.value.resources

      dynamic "condition" {
        for_each = statement.value.conditions
        content {
          test     = condition.value.test
          variable = condition.value.variable
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_role_policy" "inline" {
  for_each = {
    for role_name, role in var.roles : role_name => role
    if length(role.inline_policy_statements) > 0
  }

  name   = "${each.key}-inline"
  role   = aws_iam_role.main[each.key].id
  policy = data.aws_iam_policy_document.inline[each.key].json
}
