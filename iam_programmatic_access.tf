resource "aws_iam_user" "net_stat_api_user" {
  name = "net_stat_api_user"
  path = "/system/"
}

resource "aws_iam_access_key" "net_stat_api_user_access_key" {
  user = "${aws_iam_user.net_stat_api_user.name}"
}

resource "aws_iam_user_policy" "net_stat_api_user_policy" {
  policy = "${data.aws_iam_policy_document.net_stat_api_user_policy_document.json}"
  user = "${aws_iam_user.net_stat_api_user.name}"
}

data "aws_iam_policy_document" "net_stat_api_user_policy_document" {

  statement {

    actions = [
      "dynamodb:PutItem",
      "dynamodb:UpdateItem"
    ]

    resources = [
      "*"]
  }
}