resource "aws_iam_role" "ecs_exec_cfp_app" {
  name                 = "EcsExecCfpApp"
  description          = "EcsExecCfpApp"
  assume_role_policy   = data.aws_iam_policy_document.ecs_exec_cfp_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "ecs_exec_cfp_app_trust" {
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
        aws_iam_role.cfp_app_deployer.arn
      ]
    }
  }
}

resource "aws_iam_role_policy" "ecs_exec_cfp_app" {
  role   = aws_iam_role.ecs_exec_cfp_app.name
  policy = data.aws_iam_policy_document.ecs_exec_cfp_app.json
}

data "aws_iam_policy_document" "ecs_exec_cfp_app" {
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
    resources = [
      aws_ecr_repository.cfp_app.arn,
      aws_ecr_repository.cfp_app_apne1.arn,
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "${aws_cloudwatch_log_group.cfp_app_worker.arn}*",
      "${aws_cloudwatch_log_group.cfp_app_worker_apne1.arn}*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
    ]
    resources = ["arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/cfp-app/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
    resources = ["arn:aws:secretsmanager:ap-northeast-1:${local.kaigionrails_aws_account_id}:secret:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
    ]
    resources = [
      data.aws_kms_key.usw2_ssm.arn,
      data.aws_kms_key.apne1_ssm.arn,
    ]
  }
}

resource "aws_iam_role" "cfp_app" {
  name                 = "CfpApp"
  description          = "CfpApp"
  assume_role_policy   = data.aws_iam_policy_document.cfp_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "cfp_app_trust" {
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

resource "aws_iam_role_policy" "cfp_app" {
  role   = aws_iam_role.cfp_app.name
  policy = data.aws_iam_policy_document.cfp_app.json
}

data "aws_iam_policy_document" "cfp_app" {
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
      "arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/cfp-app/*"
    ]
  }
  statement {
    effect  = "Allow"
    actions = ["kms:Decrypt"]
    resources = [
      data.aws_kms_key.usw2_ssm.arn,
      data.aws_kms_key.apne1_ssm.arn,
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
    resources = ["arn:aws:secretsmanager:ap-northeast-1:${local.kaigionrails_aws_account_id}:secret:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "cfp_app_deployer" {
  name                 = "CfpAppDeployer"
  assume_role_policy   = data.aws_iam_policy_document.cfp_app_deployer_trust.json
  max_session_duration = 3600
}

data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "cfp_app_deployer_trust" {
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
      values   = ["repo:kaigionrails/cfp-app:*"]
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

resource "aws_iam_role_policy" "cfp_app_deployer" {
  role   = aws_iam_role.cfp_app_deployer.id
  name   = "CfpAppDeployer"
  policy = data.aws_iam_policy_document.cfp_app_deployer.json
}

data "aws_iam_policy_document" "cfp_app_deployer" {
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
      aws_iam_role.cfp_app.arn,
      aws_iam_role.ecs_exec_cfp_app.arn
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
      "apprunner:DescribeService",
    ]
    resources = ["*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "secretsmanager:GetResourcePolicy",
      "secretsmanager:GetSecretValue",
      "secretsmanager:DescribeSecret",
      "secretsmanager:ListSecretVersionIds",
    ]
    resources = ["arn:aws:secretsmanager:ap-northeast-1:${local.kaigionrails_aws_account_id}:secret:*"]
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
      aws_iam_role.ecs_exec_cfp_app.arn,
      aws_iam_role.cfp_app.arn
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "apprunner:UpdateService"
    ]
    resources = [aws_apprunner_service.cfp_app.arn]
  }
}
