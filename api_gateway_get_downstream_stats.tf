resource "aws_api_gateway_method" "get_downstream_stats" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.downstream_statistics.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_downstream_stats_integration_request" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.downstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_downstream_stats.http_method}"
  type = "AWS"
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:us-west-2:dynamodb:action/Scan"
  credentials = "${aws_iam_role.net_stat_tracker_rest_api_role.arn}"

  request_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_downstream_stats_request.json")}"
  }
}

resource "aws_api_gateway_method_response" "get_downstream_stats_200_response" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.downstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_downstream_stats.http_method}"
  status_code = 200
}

resource "aws_api_gateway_integration_response" "get_downstream_stats_200_response_integration" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.downstream_statistics.id}"
  http_method = "${aws_api_gateway_method.get_downstream_stats.http_method}"
  status_code = "${aws_api_gateway_method_response.get_downstream_stats_200_response.status_code}"

  response_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_downstream_stats_response.txt")}"
  }
}