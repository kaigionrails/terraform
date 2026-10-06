# $${...} in this file are IAM policy variables, not Terraform interpolations.

resource "aws_iam_role" "signage_app_dev_cognito_guest" {
  name                 = "${local.signage_app_dev.iam_role_prefix}CognitoGuest"
  description          = "${local.signage_app_dev.iam_role_prefix}CognitoGuest"
  assume_role_policy   = data.aws_iam_policy_document.signage_app_dev_cognito_guest_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "signage_app_dev_cognito_guest_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.signage_app_dev.id]
    }
    condition {
      test     = "ForAnyValue:StringLike" # Console warns if this is StringEquals
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["unauthenticated"]
    }
  }
}

resource "aws_iam_role_policy" "signage_app_dev_cognito_guest" {
  role   = aws_iam_role.signage_app_dev_cognito_guest.name
  policy = data.aws_iam_policy_document.signage_app_dev_cognito_guest.json
}

data "aws_iam_policy_document" "signage_app_dev_cognito_guest" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole", "sts:TagSession"]
    resources = [aws_iam_role.signage_app_dev_browser_guest.arn]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["RkSignageUserSub"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/RkSignageUserSub"
      values   = ["$${cognito-identity.amazonaws.com:sub}"]
    }
  }
}

resource "aws_iam_role" "signage_app_dev_browser_guest" {
  name                 = "${local.signage_app_dev.iam_role_prefix}BrowserGuest"
  description          = "${local.signage_app_dev.iam_role_prefix}BrowserGuest"
  assume_role_policy   = data.aws_iam_policy_document.signage_app_dev_browser_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "signage_app_dev_browser_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole", "sts:TagSession"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }
  }
}

resource "aws_iam_role_policy" "signage_app_dev_browser_guest" {
  role   = aws_iam_role.signage_app_dev_browser_guest.name
  policy = data.aws_iam_policy_document.signage_app_dev_browser_guest.json
}

data "aws_iam_policy_document" "signage_app_dev_browser_guest" {
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:Query"]
    resources = [aws_dynamodb_table.signage_app_dev.arn]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "dynamodb:LeadingKeys"
      values = [
        "*::sessions",
        "*::sponsors",
        "*::screen_controls",
        "*::venue_announcements",
      ]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:UpdateItem", "dynamodb:Query"]
    resources = [aws_dynamodb_table.signage_app_dev.arn]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "dynamodb:LeadingKeys"
      values   = ["*::kiosks:$${aws:PrincipalTag/RkSignageUserSub}"]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Connect"]
    resources = [
      "${local.iot_arn_prefix}:client/${local.signage_app_dev.name_prefix}-kiosk-*",
      "${local.iot_arn_prefix}:client/${local.signage_app_dev.name_prefix}-u-*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Publish"]
    resources = [
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/downlink/kiosk=$${aws:PrincipalTag/RkSignageUserSub}/*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Subscribe"]
    resources = [
      "${local.iot_arn_prefix}:topicfilter/${local.signage_app_dev.name_prefix}/uplink/*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Receive"]
    resources = [
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/heartbeat",
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/updates",
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/captions/*",
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/chats/*",
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/kiosk=$${aws:PrincipalTag/RkSignageUserSub}/*",
    ]
  }
}

resource "aws_iam_role" "signage_app_dev_cognito_user" {
  name                 = "${local.signage_app_dev.iam_role_prefix}CognitoUser"
  description          = "${local.signage_app_dev.iam_role_prefix}CognitoUser"
  assume_role_policy   = data.aws_iam_policy_document.signage_app_dev_cognito_user_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "signage_app_dev_cognito_user_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = ["cognito-identity.amazonaws.com"]
    }
    condition {
      test     = "StringEquals"
      variable = "cognito-identity.amazonaws.com:aud"
      values   = [aws_cognito_identity_pool.signage_app_dev.id]
    }
    condition {
      test     = "ForAnyValue:StringLike" # Console warns if this is StringEquals
      variable = "cognito-identity.amazonaws.com:amr"
      values   = ["authenticated"]
    }
  }
}

resource "aws_iam_role_policy" "signage_app_dev_cognito_user" {
  role   = aws_iam_role.signage_app_dev_cognito_user.name
  policy = data.aws_iam_policy_document.signage_app_dev_cognito_user.json
}

data "aws_iam_policy_document" "signage_app_dev_cognito_user" {
  statement {
    effect    = "Allow"
    actions   = ["sts:AssumeRole", "sts:TagSession"]
    resources = [aws_iam_role.signage_app_dev_browser_user.arn]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = ["RkSignageUserSub"]
    }
    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/RkSignageUserSub"
      values   = ["$${cognito-identity.amazonaws.com:sub}"]
    }
  }
}

resource "aws_iam_role" "signage_app_dev_browser_user" {
  name                 = "${local.signage_app_dev.iam_role_prefix}BrowserUser"
  description          = "${local.signage_app_dev.iam_role_prefix}BrowserUser"
  assume_role_policy   = data.aws_iam_policy_document.signage_app_dev_browser_trust.json
  max_session_duration = 3600
}

resource "aws_iam_role_policy" "signage_app_dev_browser_user_guest" {
  role   = aws_iam_role.signage_app_dev_browser_user.name
  policy = data.aws_iam_policy_document.signage_app_dev_browser_guest.json
}

resource "aws_iam_role_policy" "signage_app_dev_browser_user" {
  role   = aws_iam_role.signage_app_dev_browser_user.name
  policy = data.aws_iam_policy_document.signage_app_dev_browser_user.json
}

data "aws_iam_policy_document" "signage_app_dev_browser_user" {
  statement {
    effect  = "Allow"
    actions = ["dynamodb:Query"]
    resources = [
      aws_dynamodb_table.signage_app_dev.arn,
      "${aws_dynamodb_table.signage_app_dev.arn}/index/inverted",
    ]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "dynamodb:LeadingKeys"
      values   = ["*::kiosks", "*::kiosks:*"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:UpdateItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.signage_app_dev.arn]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "dynamodb:LeadingKeys"
      values = [
        "*::screen_controls",
        "*::venue_announcements",
        "*::kiosks",
        "*::kiosks:*",
      ]
    }
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Publish"]
    resources = [
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/updates",
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/kiosk=*/updates",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Subscribe"]
    resources = [
      "${local.iot_arn_prefix}:topicfilter/${local.signage_app_dev.name_prefix}/downlink/*",
    ]
  }

  statement {
    effect  = "Allow"
    actions = ["iot:Receive"]
    resources = [
      "${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/downlink/*",
    ]
  }
}

resource "aws_iam_role" "signage_app_dev_iot_handler" {
  name                 = "${local.signage_app_dev.iam_role_prefix}IotHandler"
  description          = "signage-app IotHandler"
  assume_role_policy   = data.aws_iam_policy_document.signage_app_dev_iot_handler_trust.json
  max_session_duration = 43200
}

data "aws_iam_policy_document" "signage_app_dev_iot_handler_trust" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy" "signage_app_dev_iot_handler" {
  role   = aws_iam_role.signage_app_dev_iot_handler.name
  policy = data.aws_iam_policy_document.signage_app_dev_iot_handler.json
}

data "aws_iam_policy_document" "signage_app_dev_iot_handler" {
  statement {
    effect    = "Allow"
    actions   = ["iot:Connect"]
    resources = ["${local.iot_arn_prefix}:client/${local.signage_app_dev.name_prefix}-lambda-*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iot:Publish"]
    resources = ["${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/uplink/all/heartbeat"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iot:Subscribe"]
    resources = ["${local.iot_arn_prefix}:topicfilter/${local.signage_app_dev.name_prefix}/downlink/*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["iot:Receive"]
    resources = ["${local.iot_arn_prefix}:topic/${local.signage_app_dev.name_prefix}/downlink/*"]
  }
  statement {
    effect  = "Allow"
    actions = ["dynamodb:Query"]
    resources = [
      aws_dynamodb_table.signage_app_dev.arn,
      "${aws_dynamodb_table.signage_app_dev.arn}/index/inverted",
    ]
  }
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:UpdateItem", "dynamodb:DeleteItem"]
    resources = [aws_dynamodb_table.signage_app_dev.arn]
    condition {
      test     = "ForAllValues:StringLike"
      variable = "dynamodb:LeadingKeys"
      values   = ["*::kiosks", "*::kiosks:*"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "signage_app_dev_iot_handler_lambda_basic" {
  role       = aws_iam_role.signage_app_dev_iot_handler.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}
