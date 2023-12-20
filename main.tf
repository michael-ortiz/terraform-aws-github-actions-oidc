resource "aws_iam_openid_connect_provider" "provider" {
  count = var.create_oidc_provider ? 1 : 0
  client_id_list = [
    "sts.amazonaws.com",
  ]
  thumbprint_list = var.github_thumbprints
  url             = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "github_actions_role" {
  name                 = var.role_name
  description          = "Role assumed by GitHub Actions"
  max_session_duration = var.max_session_duration
  assume_role_policy   = data.aws_iam_policy_document.policy_document.json
  depends_on           = [aws_iam_openid_connect_provider.provider]
  tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "attach" {
  count = length(var.oidc_role_policies_arns)

  policy_arn = var.oidc_role_policies_arns[count.index]
  role       = aws_iam_role.github_actions_role.name

  depends_on = [aws_iam_role.github_actions_role]
}

data "aws_iam_policy_document" "policy_document" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test = "StringLike"
      values = [
        for repo in var.repositories :
        "repo:%{if length(regexall(":+", repo)) > 0}${repo}%{else}${repo}:*%{endif}"
      ]
      variable = "token.actions.githubusercontent.com:sub"
    }

    principals {
      identifiers = [var.create_oidc_provider ? aws_iam_openid_connect_provider.provider[0].arn : ""]
      type        = "Federated"
    }
  }
}