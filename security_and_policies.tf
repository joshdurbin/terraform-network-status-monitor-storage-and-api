data "aws_iam_policy_document" "net_stat_tracker_rest_api_role_policy" {

  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type = "Service"
      identifiers = ["apigateway.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "net_stat_tracker_rest_api_role" {

  name = "net_stat_tracker_rest_api_role"
  assume_role_policy = "${data.aws_iam_policy_document.net_stat_tracker_rest_api_role_policy.json}"
}

data "aws_iam_policy_document" "dynamo_db_access_rest_gateway" {

  statement {

    actions = [
      "dynamodb:Query",
      "dynamodb:Scan",
    ]

    resources = [
      "${aws_dynamodb_table.net_stat_tracker_downstream_modem_stats.arn}",
      "${aws_dynamodb_table.net_stat_tracker_echo_responses.arn}",
      "${aws_dynamodb_table.net_stat_tracker_modem_logs.arn}",
      "${aws_dynamodb_table.net_stat_tracker_upstream_modem_stats.arn}"
    ]
  }
}

resource "aws_iam_role_policy" "dynamo_db_access_rest_gateway" {

  name = "dynamo_db_access_rest_gateway"
  role = "${aws_iam_role.net_stat_tracker_rest_api_role.id}"
  policy = "${data.aws_iam_policy_document.dynamo_db_access_rest_gateway.json}"
}
