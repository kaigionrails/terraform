resource "aws_iam_role" "ecs_exec_conference_app" {
  name                 = "EcsExecConferenceApp"
  description          = "EcsExecConferenceApp"
  assume_role_policy   = data.aws_iam_policy_document.ecs_exec_conference_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "ecs_exec_conference_app_trust" {
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
        aws_iam_role.conference_app_deployer.arn
      ]
    }
  }
}

resource "aws_iam_role_policy" "ecs_exec_conference_app" {
  role   = aws_iam_role.ecs_exec_conference_app.name
  policy = data.aws_iam_policy_document.ecs_exec_conference_app.json
}

data "aws_iam_policy_document" "ecs_exec_conference_app" {
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
    resources = [aws_ecr_repository.conference_app.arn]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["${aws_cloudwatch_log_group.conference_app_worker.arn}*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "ssm:GetParameters",
    ]
    resources = ["arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/conference-app/*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "kms:Decrypt",
    ]
    resources = [data.aws_kms_key.usw2_ssm.arn]
  }
}

resource "aws_iam_role" "conference_app" {
  name                 = "ConferenceApp"
  description          = "ConferenceApp"
  assume_role_policy   = data.aws_iam_policy_document.conference_app_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "conference_app_trust" {
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

resource "aws_iam_role_policy" "conference_app" {
  role   = aws_iam_role.conference_app.name
  policy = data.aws_iam_policy_document.conference_app.json
}

data "aws_iam_policy_document" "conference_app" {
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
      "arn:aws:ssm:*:${local.kaigionrails_aws_account_id}:parameter/conference-app/*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["kms:Decrypt"]
    resources = [data.aws_kms_key.usw2_ssm.arn]
  }
}

resource "aws_iam_role" "conference_app_deployer" {
  name                 = "ConferenceAppDeployer"
  assume_role_policy   = data.aws_iam_policy_document.conference_app_deployer_trust.json
  max_session_duration = 3600
}

data "aws_iam_openid_connect_provider" "github_actions" {
  url = "https://token.actions.githubusercontent.com"
}

data "aws_iam_policy_document" "conference_app_deployer_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github_actions.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:kaigionrails/conference-app:*"]
    }
  }
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.kaigionrails_aws_account_id}:role/OrganizationAccountAccessRole"]
    }
  }
}

resource "aws_iam_role_policy" "conference_app_deployer" {
  role   = aws_iam_role.conference_app_deployer.id
  name   = "ConferenceAppDeployer"
  policy = data.aws_iam_policy_document.conference_app_deployer.json
}

data "aws_iam_policy_document" "conference_app_deployer" {
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
  # statement {
  #   effect  = "Allow"
  #   actions = ["iam:PassRole"]
  #   resources = [
  #     aws_iam_role.conference_app.arn,
  #     aws_iam_role.ecs_exec_conference_app.arn
  #   ]
  # }
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
      aws_iam_role.ecs_exec_conference_app.arn,
      aws_iam_role.conference_app.arn
    ]
  }
}
