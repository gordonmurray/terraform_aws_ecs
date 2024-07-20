resource "aws_kms_key" "flow_logs" {
  description         = "KMS key for VPC Flow Logs"
  enable_key_rotation = true
}
