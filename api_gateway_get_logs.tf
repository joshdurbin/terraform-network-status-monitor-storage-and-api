resource "aws_api_gateway_method" "get_logs" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.logs.id}"
  http_method = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get_logs_integration_request" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.logs.id}"
  http_method = "${aws_api_gateway_method.get_logs.http_method}"
  type = "AWS"
  integration_http_method = "POST"
  uri = "arn:aws:apigateway:us-west-2:dynamodb:action/Scan"
  credentials = "${aws_iam_role.net_stat_tracker_rest_api_role.arn}"

  request_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_logs_request.json")}"
  }
}

resource "aws_api_gateway_method_response" "get_logs_200_response" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.logs.id}"
  http_method = "${aws_api_gateway_method.get_logs.http_method}"
  status_code = 200
}

resource "aws_api_gateway_integration_response" "get_logs_200_response_integration" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  resource_id = "${aws_api_gateway_resource.logs.id}"
  http_method = "${aws_api_gateway_method.get_logs.http_method}"
  status_code = "${aws_api_gateway_method_response.get_logs_200_response.status_code}"

  response_templates {

    "application/json" = "${file("${path.module}/api_gateway_templates/get_logs_response.txt")}"
  }
}