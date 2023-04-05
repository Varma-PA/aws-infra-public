resource "aws_cloudwatch_log_group" "csye6225" {
  name              = "csye6225"
  retention_in_days = 0
}

resource "aws_cloudwatch_log_stream" "webapp-log-stream" {
  name           = "webapp"
  log_group_name = aws_cloudwatch_log_group.csye6225.name
}
