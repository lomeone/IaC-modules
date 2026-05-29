data "aws_iam_policy_document" "assume_role" {
  for_each = var.service_accounts

  dynamic "statement" {
    for_each = each.value.eks_bindings # key = eks_cluster key
    content {
      effect  = "Allow"
      actions = ["sts:AssumeRoleWithWebIdentity"]

      principals {
        type        = "Federated"
        identifiers = [var.eks_clusters[statement.key].oidc_arn]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(var.eks_clusters[statement.key].oidc_url, "https://", "")}:sub"
        values = [
          for b in statement.value : "system:serviceaccount:${b.namespace}:${b.service_account_name}"
        ]
      }

      condition {
        test     = "StringEquals"
        variable = "${replace(var.eks_clusters[statement.key].oidc_url, "https://", "")}:aud"
        values   = ["sts.amazonaws.com"]
      }
    }
  }
}

resource "aws_iam_role" "main" {
  for_each = var.service_accounts

  name                 = each.key
  description          = each.value.description
  assume_role_policy   = data.aws_iam_policy_document.assume_role[each.key].json
  max_session_duration = each.value.max_session_duration
  tags                 = each.value.tags
}

resource "aws_iam_role_policy_attachment" "managed" {
  for_each = {
    for pair in flatten([
      for role_name, sa in var.service_accounts : [
        for arn in sa.policy_arns : {
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
    for role_name, sa in var.service_accounts : role_name => sa
    if length(sa.inline_policy_statements) > 0
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
    for role_name, sa in var.service_accounts : role_name => sa
    if length(sa.inline_policy_statements) > 0
  }

  name   = "${each.key}-inline"
  role   = aws_iam_role.main[each.key].id
  policy = data.aws_iam_policy_document.inline[each.key].json
}
