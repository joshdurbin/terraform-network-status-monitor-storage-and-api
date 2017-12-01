variable "number_of_generated_api_keys" {
  default = 1
}

variable "usage_plan_per_user_quota_offset" {
  description = "The number of requests subtracted from the given limit in the initial time period."
  default = 0
}

variable "usage_plan_per_user_quota" {
  description = "The maximum number of requests that can be made in a given time period."
  default = 25
}

variable "usage_plan_per_user_quota_period" {
  description = "The time period in which the limit applies. Valid values are DAY, WEEK or MONTH."
  default = "DAY"
}

variable "usage_plan_rate_limit" {
  description = "The API request steady-state rate limit."
  default = 100
}

variable "usage_plan_burst_limit" {
  description = "The API request burst limit, the maximum rate limit over a time ranging from one to a few seconds, depending upon whether the underlying token bucket is at its full capacity."
  default = 150
}

variable "aws_region" {
  default = "us-west-2"
}