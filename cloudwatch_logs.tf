resource "aws_cloudwatch_log_group" "flow_logs" {
  name              = "vpc-flow-logs"
  retention_in_days = 7
  kms_key_id        = aws_kms_key.flow_logs.arn
}


resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "ecs-log-group"
  retention_in_days = 7
}

