resource "aws_iam_role" "github_action" {
  name               = "GitHubActionRole"
  assume_role_policy = data.aws_iam_policy_document.github_action_oidc_assume_role.json
}

data "aws_iam_policy_document" "github_action_oidc_assume_role" {
  version = "2012-10-17"

  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:lomeone/*:*"]
    }

    principals {
      identifiers = [var.github_action.oidc_arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role_policy_attachment" "github_action_ECRPullPolicy" {
  role       = aws_iam_role.github_action.name
  policy_arn = "arn:aws:iam::396428372646:policy/ECRPullPolicy"
}

resource "aws_iam_role_policy_attachment" "github_action_GithubActionECRPolicy" {
  role       = aws_iam_role.github_action.name
  policy_arn = aws_iam_policy.github_action_ECRPolicy.arn
}

resource "aws_iam_policy" "github_action_ECRPolicy" {
  name   = "GithubActionECRPolicy"
  policy = data.aws_iam_policy_document.github_action_ECRPolicy.json
}

data "aws_iam_policy_document" "github_action_ECRPolicy" {
  version = "2012-10-17"

  statement {
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:PutImage"
    ]

    effect = "Allow"

    resources = ["*"]
  }
}
