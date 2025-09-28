data "aws_iam_policy_document" "shirataki_ec2_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

data "aws_iam_policy_document" "shirataki_ec2" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket",
    ]
    resources = [
      "arn:aws:s3:::*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject",
    ]
    resources = [
      "${data.aws_s3_bucket.kaigionrails_logs.arn}/*",
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = ["arn:aws:logs:*:*:*"]
  }
  statement {
    effect = "Allow"
    actions = [
      "bedrock:InvokeModel",
      "bedrock:InvokeModelWithResponseStream",
    ]
    resources = [
      "arn:aws:bedrock:*::*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "transcribe:StartStreamTranscription",
      "transcribe:StartStreamTranscriptionWebsocket",
      "transcribe:ListLanguageModels",
    ]
    resources = ["*"]
  }
}

# Managed Policy
data "aws_iam_policy" "AWSSystemsManagerJustInTimeAccessTokenSessionPolicy" {
  arn = "arn:aws:iam::aws:policy/AWSSystemsManagerJustInTimeAccessTokenSessionPolicy"
}

data "aws_iam_policy" "AmazonSSMManagedInstanceCore" {
  arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role" "shirataki_ec2" {
  name               = "ShiratakiEC2"
  description        = "ShiratakiEC2"
  assume_role_policy = data.aws_iam_policy_document.shirataki_ec2_trust.json
}

resource "aws_iam_role_policy" "shirataki_ec2" {
  role   = aws_iam_role.shirataki_ec2.name
  policy = data.aws_iam_policy_document.shirataki_ec2.json
}

resource "aws_iam_policy_attachment" "shirataki_ec2_ssm_jit" {
  name       = "ShiratakiEC2-SSM-JIT"
  roles      = [aws_iam_role.shirataki_ec2.name]
  policy_arn = data.aws_iam_policy.AWSSystemsManagerJustInTimeAccessTokenSessionPolicy.arn
}

resource "aws_iam_policy_attachment" "shirataki_ec2_ssm_instance_core" {
  name       = "ShiratakiEC2-SSM"
  roles      = [aws_iam_role.shirataki_ec2.name]
  policy_arn = data.aws_iam_policy.AmazonSSMManagedInstanceCore.arn
}

resource "aws_iam_instance_profile" "shirataki_ec2" {
  name = "ShiratakiEC2"
  role = aws_iam_role.shirataki_ec2.name
}
