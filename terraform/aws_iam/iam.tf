resource "aws_iam_role" "GithubActionsRole" {
  name = "GithubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.GithubActionsRole.json
}

data "aws_iam_policy_document" "GithubActionsRole" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = ["sts.amazonaws.com"]
    }
    condition {
      test     = "ForAllValues:StringEquals"
      variable = "token.actions.githubusercontent.com:iss"
      values   = ["https://token.actions.githubusercontent.com"]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = ["repo:lynxBios/rsschool-devops-course-tasks:*"]
    }

    principals {
      type        = "Federated"
      identifiers = ["arn:aws:iam::${variables.account_id}:oidc-provider/token.actions.githubusercontent.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_ec2" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_route53" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonRoute53FullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_s3" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_iam" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/IAMFullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_vpc" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_sqs" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSQSFullAccess"
}

resource "aws_iam_role_policy_attachment" "GithubActionsRole_eventbridge" {
  role       = aws_iam_role.GithubActionsRole.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEventBridgeFullAccess"
}
