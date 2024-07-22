#!/bin/bash
set -e

# Install Docker
amazon-linux-extras install -y docker
systemctl enable docker
systemctl start docker
usermod -a -G docker ec2-user

# Wait for Docker to be fully started
until [ "$(systemctl is-active docker)" = "active" ]; do
  sleep 1
done

# Install ECS Agent
mkdir -p /etc/ecs
echo "ECS_CLUSTER=${ecs_cluster}" | tee -a /etc/ecs/ecs.config
amazon-linux-extras install -y ecs
systemctl enable ecs
systemctl start ecs

# Wait for ECS Agent to be fully started
until [ "$(systemctl is-active ecs)" = "active" ]; do
  sleep 1
done

# Install SSM Agent
amazon-linux-extras install -y aws-ssm-agent
systemctl enable amazon-ssm-agent
systemctl start amazon-ssm-agent

# Wait for SSM Agent to be fully started
until [ "$(systemctl is-active amazon-ssm-agent)" = "active" ]; do
  sleep 1
done
