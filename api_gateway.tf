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

resource "aws_api_gateway_api_key" "key" {

  count = "${var.number_of_generated_api_keys}"

  name = "canary_sensor_api-${aws_api_gateway_deployment.prod_deployment.stage_name}-key-${count.index}"
}

resource "aws_api_gateway_usage_plan" "net_stat_tracker_api" {

  count = "${var.number_of_generated_api_keys > 0 ? 1 : 0}"

  name = "canary_sensor_data_api_usage_plan"

  api_stages {
    api_id = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
    stage = "${aws_api_gateway_deployment.prod_deployment.stage_name}"
  }

  quota_settings {

    limit = "${var.usage_plan_per_user_quota}"
    offset = "${var.usage_plan_per_user_quota_offset}"
    period = "${var.usage_plan_per_user_quota_period}"
  }

  throttle_settings {
    burst_limit = "${var.usage_plan_burst_limit}"
    rate_limit = "${var.usage_plan_rate_limit}"
  }
}

resource "aws_api_gateway_usage_plan_key" "canary_sensor_data_api" {

  count = "${var.number_of_generated_api_keys}"

  key_id = "${element(aws_api_gateway_api_key.key.*.id, count.index)}"
  key_type = "API_KEY"
  usage_plan_id = "${aws_api_gateway_usage_plan.net_stat_tracker_api.id}"
}