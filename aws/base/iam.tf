resource "aws_iam_openid_connect_provider" "github_actions" {
  url             = "https://token.actions.githubusercontent.com"
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["1b511abead59c6ce207077c0bf0e0043b1382612"]
  tags = {
    "Project" = "kaigionrails"
  }
}

resource "aws_iam_role" "GhaDockerPushToEcr" {
  name               = "GhaDockerPushToEcr"
  assume_role_policy = data.aws_iam_policy_document.GhaDockerPushToEcrTrustRelation.json
}

resource "aws_iam_role_policy" "GhaDockerPushToEcr" {
  role   = aws_iam_role.GhaDockerPushToEcr.id
  name   = "GhaDockerPhshToEcr"
  policy = data.aws_iam_policy_document.GhaDockerPushToEcrPolicy.json
}


data "aws_iam_policy_document" "GhaDockerPushToEcrPolicy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "sts:GetServiceBearerToken",
    ]
    resources = ["*"]
  }

  statement {
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:DescribeRepositories",
      "ecr:ListImages",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]
    resources = [
      "arn:aws:ecr:us-west-2:${data.aws_caller_identity.curent.account_id}:repository/cfp-app",
      "arn:aws:ecr:us-west-2:${data.aws_caller_identity.curent.account_id}:repository/sponsor-app",
      "arn:aws:ecr:us-west-2:${data.aws_caller_identity.curent.account_id}:repository/conference-app",
    ]
  }
}

data "aws_iam_policy_document" "GhaDockerPushToEcrTrustRelation" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [aws_iam_openid_connect_provider.github_actions.arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:kaigionrails/cfp-app:*",
        "repo:kaigionrails/sponsor-app:*",
        "repo:kaigionrails/conference-app:*",
      ]
    }
  }
}


