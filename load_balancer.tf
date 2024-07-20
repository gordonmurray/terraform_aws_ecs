resource "aws_lb" "main" {
  name                       = "${var.application_name}-ecs-load-balancer"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.lb_sg.id]
  subnets                    = aws_subnet.private[*].id
  enable_deletion_protection = false
  drop_invalid_header_fields = true
}

resource "aws_lb_target_group" "main" {
  name        = "${var.application_name}-ecs-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc.id
  target_type = "ip"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }
}
