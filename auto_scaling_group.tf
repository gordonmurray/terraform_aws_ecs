resource "aws_autoscaling_group" "ecs" {
  name                = "${var.application_name}-ecs-asg"
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1
  vpc_zone_identifier = aws_subnet.private[*].id

  launch_template {
    id      = aws_launch_template.ecs.id
    version = "$Latest"
  }

  target_group_arns = [
    aws_lb_target_group.nginx.arn
  ]

  tag {
    key                 = "Name"
    value               = "${var.application_name}-ecs-instance"
    propagate_at_launch = true
  }
}
