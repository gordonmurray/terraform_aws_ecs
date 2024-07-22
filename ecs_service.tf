resource "aws_ecs_service" "nginx" {
  name            = "nginx"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.nginx.arn
  desired_count   = 1
  launch_type     = "EC2"

  load_balancer {
    target_group_arn = aws_lb_target_group.nginx.arn
    container_name   = "nginx" # Use the container name from the task definition
    container_port   = 80
  }

  depends_on = [aws_lb_listener.nginx_http]
}
