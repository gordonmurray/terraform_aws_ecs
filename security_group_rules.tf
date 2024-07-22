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

resource "aws_security_group_rule" "allow_lb_to_ec2" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.ecs_sg.id
  source_security_group_id = aws_security_group.lb_sg.id
  description              = "Allow HTTP traffic from the load balancer to ECS instances"
}

resource "aws_security_group_rule" "allow_ecs_agent_health_check" {
  type              = "ingress"
  from_port         = 51678
  to_port           = 51678
  protocol          = "tcp"
  security_group_id = aws_security_group.ecs_sg.id
  cidr_blocks       = ["10.0.0.0/16"] #  VPC's CIDR block
  description       = "Allow ECS agent health check"
}


resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.ecs_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "Allow all outbound traffic"
}

