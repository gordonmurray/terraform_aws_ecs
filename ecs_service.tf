resource "aws_ecs_service" "main" {
  name            = "${var.application_name}-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "EC2"

  network_configuration {
    subnets         = aws_subnet.private[*].id
    security_groups = [aws_security_group.lb_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "triton" # Use the container name from the task definition
    container_port   = 8000
  }

  depends_on = [aws_lb_listener.http]
}
