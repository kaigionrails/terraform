resource "aws_iam_role" "ecs_exec_sponsor_app" {
  name                 = "EcsExecSponsorApp"
  description          = "EcsExecSponsorApp"
  assume_role_policy   = data.aws_iam_policy_document.ecs_exec_sponsor_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "ecs_exec_sponsor_app_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::861452569180:role/OrganizationAccountAccessRole",
        aws_iam_role.sponsor_app_deployer.arn
      ]
    }
  }
}

resource "aws_iam_role_policy" "ecs_exec_sponsor_app" {
  role   = aws_iam_role.ecs_exec_sponsor_app.name
  policy = data.aws_iam_policy_document.ecs_exec_sponsor_app.json
}

data "aws_iam_policy_document" "ecs_exec_sponsor_app" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "sts:GetServiceBearerToken"
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
    ]
    resources = [aws_ecr_repository.sponsor_app.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["${aws_cloudwatch_log_group.sponsor_app_worker.arn}*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
    ]
    resources = ["arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/sponsor-app/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
    ]
    resources = [data.aws_kms_key.usw2_ssm.arn]
  }
}

resource "aws_iam_role" "sponsor_app" {
  name                 = "SponsorApp"
  description          = "SponsorApp"
  assume_role_policy   = data.aws_iam_policy_document.sponsor_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "sponsor_app_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com",
      ]
    }
  }
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = [
        "tasks.apprunner.amazonaws.com"
      ]
    }
  }
}

resource "aws_iam_role_policy" "sponsor_app" {
  role   = aws_iam_role.sponsor_app.name
  policy = data.aws_iam_policy_document.sponsor_app.json
}

data "aws_iam_policy_document" "sponsor_app" {
  # TODO: SQS
  # statement {
  #   effect    = "Allow"
  #   actions   = [
  #     "sqs:SendMessage",
  #     "sqs:ReceiveMessage",
  #     "sqs:DeleteMessage",
  #     "sqs:ChangeMessageVisibility",
  #     "sqs:GetQueueAttributes",
  #     "sqs:GetQueueUrl",
  #     ]
  #   resources = []
  # }
  # statement {
  #   effect  = "Allow"
  #   actions = ["iam:GetRole"]
  #   # resources = ["arn:aws:iam::${local.kaigionrails_aws_account_id}:role/*"]
  #   resources = ["*"]
  # }
  statement {
    effect  = "Allow"
    actions = ["ssm:GetParameters"]
    resources = [
      "arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/sponsor-app/*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [data.aws_kms_key.usw2_ssm.arn]
  }
}

resource "aws_iam_role" "sponsor_app_deployer" {
  name                 = "SponsorAppDeployer"
  assume_role_policy   = data.aws_iam_policy_document.sponsor_app_deployer_trust.json
  max_session_duration = 3600
}

data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "sponsor_app_deployer_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:kaigionrails/sponsor-app:*"]
    }
  }
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "AWS"
      identifiers = [
        "arn:aws:iam::${local.kaigionrails_aws_account_id}:role/OrganizationAccountAccessRole"
      ]
    }
  }
}

resource "aws_iam_role_policy" "sponsor_app_deployer" {
  role   = aws_iam_role.sponsor_app_deployer.id
  name   = "SponsorAppDeployer"
  policy = data.aws_iam_policy_document.sponsor_app_deployer.json
}

data "aws_iam_policy_document" "sponsor_app_deployer" {
  statement {
    effect    = "Allow"
    actions   = ["ecs:*"]
    resources = ["*"]
    # TODO: tagging
    # condition {
    #   test = "StringEquals"
    #   variable = "aws:RequestTag/foobar"
    #   values = ["baz"]
    # }
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:DescribeLogGroups"
    ]
    resources = ["*"]
  }
  statement {
    effect  = "Allow"
    actions = ["iam:PassRole"]
    resources = [
      aws_iam_role.sponsor_app.arn,
      aws_iam_role.ecs_exec_sponsor_app.arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ec2:Deescribe*",
      "elasticloadbalancing:Describe*",
      "ecs:Describe*",
      "ecs:List*",
      "ecr:List*",
      "ssm:GetParameters",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "iam:Get*",
      "iam:ListRolePolicies",
      "iam:ListAttachedRolePolicies"
    ]
    resources = ["*"]
  }
  # ecspresso
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole",
    ]
    resources = [
      aws_iam_role.ecs_exec_sponsor_app.arn,
      aws_iam_role.sponsor_app.arn
    ]
  }
  # statement {
  #   effect = "Allow"
  #   actions = [
  #     "apprunner:UpdateService"
  #   ]
  #   resources = [aws_apprunner_service.sponsor_app.arn]
  # }
}
