resource "aws_api_gateway_rest_api" "net_stat_tracker_api" {

  name = "net_stat_tracker"
  description = "REST API using templating to pass requests through to Query operations against DynamoDB"
}

resource "aws_api_gateway_resource" "echo" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  parent_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.root_resource_id}"
  path_part = "echo"
}

resource "aws_api_gateway_resource" "modem" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  parent_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.root_resource_id}"
  path_part = "modem"
}

resource "aws_api_gateway_resource" "downstream_statistics" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  parent_id = "${aws_api_gateway_resource.modem.id}"
  path_part = "downstreamStats"
}

resource "aws_api_gateway_resource" "upstream_statistics" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  parent_id = "${aws_api_gateway_resource.modem.id}"
  path_part = "upstreamStats"
}

resource "aws_api_gateway_resource" "logs" {

  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  parent_id = "${aws_api_gateway_resource.modem.id}"
  path_part = "logs"
}

resource "aws_api_gateway_deployment" "prod_deployment" {
  
  rest_api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
  stage_name  = "prod"
}