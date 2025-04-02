# IAM OIDC provider for GitHub Actions
resource "aws_iam_openid_connect_provider" "openid_connect_provider" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1c58a3a8518e8759bf075b76b750d4f2df264fcd"]

  tags = {
    Name = "${var.project_name}-github-provider"
  }
}

data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "github_trust" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = [var.jwt_subject_claim]
    }
  }
}

# IAM role for GitHub Actions to assume
resource "aws_iam_role" "role" {
  name               = "${var.project_name}-github-role"
  assume_role_policy = data.aws_iam_policy_document.github_trust.json

  tags = {
    Name = "${var.project_name}-github-role"
  }
}

# Ideally this would follow least-privilege principles
data "aws_iam_policy_document" "role_access" {
  statement {
    actions   = ["ecr:*", "ecs:*"]
    resources = ["*"]
  }
}

# Allow GitHub Actions to use ECR, ECS
resource "aws_iam_role_policy" "role_policy" {
  name   = "ecr-ecs-access"
  role   = aws_iam_role.role.id
  policy = data.aws_iam_policy_document.role_access.json
}
