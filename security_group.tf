resource "aws_security_group" "lb_sg" {
  name        = "${var.application_name}-lb-sg"
  description = "Security group for the internal load balancer"
  vpc_id      = aws_vpc.vpc.id

  tags = {
    Name = "${var.application_name}-lb-sg"
  }
}
