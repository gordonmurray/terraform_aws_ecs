resource "aws_ecs_service" "main" {
  name            = "${var.application_name}-ecs-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 0

  launch_type = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = var.application_name
    container_port   = 80
  }

  depends_on = [aws_lb_listener.http]
}
