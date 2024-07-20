data "aws_ami" "deep_learning_base" {
  most_recent = true
  filter {
    name   = "name"
    values = ["Deep Learning Base OSS Nvidia Driver AMI (Amazon Linux 2) Version 65.7"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}


resource "aws_launch_configuration" "ecs" {
  name                 = "${var.application_name}-ecs-launch-configuration"
  image_id             = data.aws_ami.deep_learning_base.id
  instance_type        = "g5.xlarge"
  iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
  security_groups      = [aws_security_group.ecs_sg.id]

  metadata_options {
    http_tokens = "required"
  }

  root_block_device {
    encrypted = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo ECS_CLUSTER=${aws_ecs_cluster.main.name} >> /etc/ecs/ecs.config
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecsInstanceProfile"
  role = aws_iam_role.ecs_instance_role.name
}
