resource "aws_security_group_rule" "allow_private_8080" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  cidr_blocks       = var.private_subnet_cidrs
  security_group_id = aws_security_group.lb_sg.id
  description       = "Allow traffic from private subnets on port 8080"
}

resource "aws_security_group_rule" "allow_all_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.lb_sg.id
  description       = "Allow all outbound traffic"
}
