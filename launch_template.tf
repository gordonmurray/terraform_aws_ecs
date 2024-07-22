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

resource "aws_launch_template" "ecs" {
  name_prefix   = "${var.application_name}-ecs-launch-template"
  image_id      = data.aws_ami.deep_learning_base.id
  instance_type = "g5.xlarge"

  iam_instance_profile {
    name = aws_iam_instance_profile.ecs_instance_profile.name
  }

  metadata_options {
    http_tokens = "required"
  }

  network_interfaces {
    associate_public_ip_address = false
    security_groups             = [aws_security_group.ecs_sg.id]
  }

  user_data = base64encode(<<-EOF
              #!/bin/bash
              # Install Docker
              amazon-linux-extras install -y docker
              service docker start
              usermod -a -G docker ec2-user

              # Install ECS Agent
              mkdir -p /etc/ecs
              echo "ECS_CLUSTER=my-ecs-app-ecs-cluster" | sudo tee -a /etc/ecs/ecs.config
              amazon-linux-extras install -y ecs
              systemctl enable ecs
              systemctl start ecs

              # Install SSM Agent
              amazon-linux-extras install -y aws-ssm-agent
              systemctl enable amazon-ssm-agent
              systemctl start amazon-ssm-agent
              EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.application_name}-ecs-instance"
    }
  }
}
