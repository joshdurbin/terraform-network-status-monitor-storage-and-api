resource "aws_api_gateway_method" "get_upstream_stats" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.upstream_statistics.id}"
  http_method = "GET"
  authorization = "NONE"
  api_key_required = "${var.number_of_generated_api_keys > 0 ? true : false}"
}

resource "aws_api_gateway_integration" "get_upstream_stats_integration_request" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.upstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_upstream_stats.http_method}"
  type = "AWS"
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:${var.aws_region}:dynamodb:action/Scan"
  credentials = "${aws_iam_role.net_stat_tracker_rest_api_role.arn}"

  request_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_upstream_stats_request.json")}"
  }
}

resource "aws_api_gateway_method_response" "get_upstream_stats_200_response" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.upstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_upstream_stats.http_method}"
  status_code = 200
}

resource "aws_api_gateway_integration_response" "get_upstream_stats_200_response_integration" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.upstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_upstream_stats.http_method}"
  status_code = "${aws_api_gateway_method_response.get_upstream_stats_200_response.status_code}"

  response_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_upstream_stats_response.txt")}"
  }
}