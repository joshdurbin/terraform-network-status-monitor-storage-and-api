# terraform-network-status-monitor-storage-and-api

This is a terraform module that creates a set of dynamodb tables and an API Gateway. The dynamodb tables are used by a [client](https://github.com/joshdurbin/network-status-monitor) to store network and cable modem statistics. The API Gateway uses services passthrus to allow information retrieval.

## Input variables:

  * `number_of_generated_api_keys` - The number of API keys to generate for use against the API, which defaults to `1`
  * `usage_plan_per_user_quota_offset` - The number of requests subtracted from the given limit in the initial time period, defaults to `0` (value must be zero for `usage_plan_per_user_quota_period` of `DAY`)
  * `usage_plan_per_user_quota` - The maximum number of requests that can be made in a given time period, defaults to `25`
  * `usage_plan_per_user_quota_period` - The time period in which the limit applies. Valid values are DAY, WEEK or MONTH, defaults to `DAY`
  * `usage_plan_rate_limit` - The API request steady-state rate limit, defaults to `100`
  * `usage_plan_burst_limit` - The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity, defaults to `150`
  * `aws_region` - The region for the API calls.

## Outputs:

  * `api_gateway_endpoint` - The API Gateway endpoint
  * `direct_dynamodb_access_key` - The access key the [client](https://github.com/joshdurbin/network-status-monitor) will use
  * `direct_dynamodb_secret_key` - The secret key the [client](https://github.com/joshdurbin/network-status-monitor) will use
  * `rest_api_keys` - The API Gateway endpoint keys
  * `api_id` - The API Gateway id
  * `api_stage_name` - The API Gateway stage name

## Example:

Basic example - In your terraform code add something like this:

    module "net_stat_tracker" {
      source = "github.com/joshdurbin/terraform-network-status-monitor-storage-and-api"
      number_of_generated_api_keys = 1
    }

    output "my_net_stat_tracker_api_keys" {
      value = "${module.net_stat_tracker.rest_api_keys}"
    }

    output "my_net_stat_tracker_canary_api_gateway_endpoint" {
      value = "${module.net_stat_tracker.api_gateway_endpoint}"
    }

    output "my_net_stat_tracker_app_access_key" {
      value = "${module.net_stat_tracker.direct_dynamodb_access_key}"
    }

    output "my_net_stat_tracker_app_secret_key" {
      value = "${module.net_stat_tracker.direct_dynamodb_secret_key}"
    }

## Authors

Created and maintained by [Josh Durbin](https://github.com/joshdurbin).

# License

Apache 2 Licensed. See LICENSE for full details.
