resource "aws_dynamodb_table" "net_stat_tracker_downstream_modem_stats" {

  name = "net_stat_tracker_downstream_modem_stats"
  read_capacity = 1
  write_capacity = 1
  hash_key = "timestamp"
  range_key = "channel"

  ttl {
    attribute_name = "expirationTTL"
    enabled = true
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "channel"
    type = "S"
  }

  tags {
    managed-by-terraform = true
  }

}

resource "aws_dynamodb_table" "net_stat_tracker_upstream_modem_stats" {

  name = "net_stat_tracker_upstream_modem_stats"
  read_capacity = 1
  write_capacity = 1
  hash_key = "timestamp"
  range_key = "channel"

  ttl {
    attribute_name = "expirationTTL"
    enabled = true
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "channel"
    type = "S"
  }

  tags {
    managed-by-terraform = true
  }

}

resource "aws_dynamodb_table" "net_stat_tracker_echo_responses" {

  name = "net_stat_tracker_echo_responses"
  read_capacity = 1
  write_capacity = 1
  hash_key = "timestamp"
  range_key = "endpoint"

  ttl {
    attribute_name = "expirationTTL"
    enabled = true
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  attribute {
    name = "endpoint"
    type = "S"
  }

  tags {
    managed-by-terraform = true
  }

}

resource "aws_dynamodb_table" "net_stat_tracker_modem_logs" {

  name = "net_stat_tracker_modem_logs"
  read_capacity = 1
  write_capacity = 1
  hash_key = "timestamp"

  ttl {
    attribute_name = "expirationTTL"
    enabled = true
  }

  attribute {
    name = "timestamp"
    type = "S"
  }

  tags {
    managed-by-terraform = true
  }

}