output "api_gateway_endpoint" {
  value = "https://${aws_api_gateway_deployment.prod_deployment.rest_api_id}.execute-api.${var.aws_region}.amazonaws.com/${aws_api_gateway_deployment.prod_deployment.stage_name}"
}

output "direct_dynamodb_access_key" {
  value = "${aws_iam_access_key.net_stat_api_user_access_key.id}"
}

output "direct_dynamodb_secret_key" {
  value = "${aws_iam_access_key.net_stat_api_user_access_key.secret}"
}

output "rest_api_keys" {
  value = ["${aws_api_gateway_api_key.key.*.id}"]
}

output "api_id" {
  value = "${aws_api_gateway_rest_api.net_stat_tracker_api.id}"
}

output "api_stage_name" {
  value = "${aws_api_gateway_deployment.prod_deployment.stage_name}"
}