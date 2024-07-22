resource "aws_lb" "main" {
  name                       = "${var.application_name}-ecs-load-balancer"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb_sg.id]
  subnets                    = aws_subnet.private[*].id
  enable_deletion_protection = false
  drop_invalid_header_fields = true
}
