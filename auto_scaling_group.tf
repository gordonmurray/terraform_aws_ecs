resource "aws_autoscaling_group" "ecs" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  launch_configuration = aws_launch_configuration.ecs.id
  vpc_zone_identifier  = aws_subnet.private[*].id

  tag {
    key                 = "Name"
    value               = "${var.application_name}-ecs-instance"
    propagate_at_launch = true
  }
}
