# ECS cluster on AWS using Terraform

This project sets up an AWS infrastructure including a VPC with public and private subnets, an ECS cluster, and associated resources for running containerized applications.


### Estimated monthly cost (Assuming eu-west-1)

```
Project: terraform_aws_ecs

 Name                                                           Monthly Qty  Unit                    Monthly Cost

 aws_autoscaling_group.ecs
 └─ aws_launch_template.ecs
    └─ Instance usage (Linux/UNIX, on-demand, g5.xlarge)                730  hours                        $819.79

 aws_nat_gateway.main
 ├─ NAT gateway                                                         730  hours                         $35.04
 └─ Data processed                                        Monthly cost depends on usage: $0.048 per GB

 aws_lb.main
 ├─ Application load balancer                                           730  hours                         $18.40
 └─ Load balancer capacity units                          Monthly cost depends on usage: $5.84 per LCU

 aws_kms_key.ecr_key
 ├─ Customer master key                                                   1  months                         $1.00
 ├─ Requests                                              Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.ecs_logs
 ├─ Customer master key                                                   1  months                         $1.00
 ├─ Requests                                              Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests

 aws_kms_key.flow_logs
 ├─ Customer master key                                                   1  months                         $1.00
 ├─ Requests                                              Monthly cost depends on usage: $0.03 per 10k requests
 ├─ ECC GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests
 └─ RSA GenerateDataKeyPair requests                      Monthly cost depends on usage: $0.10 per 10k requests

 aws_cloudwatch_log_group.ecs_log_group
 ├─ Data ingested                                         Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                                      Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned                         Monthly cost depends on usage: $0.0057 per GB

 aws_cloudwatch_log_group.flow_logs
 ├─ Data ingested                                         Monthly cost depends on usage: $0.57 per GB
 ├─ Archival Storage                                      Monthly cost depends on usage: $0.03 per GB
 └─ Insights queries data scanned                         Monthly cost depends on usage: $0.0057 per GB

 aws_ecr_repository.repository
 └─ Storage                                               Monthly cost depends on usage: $0.10 per GB

 OVERALL TOTAL                                                                                           $876.23

*Usage costs can be estimated by updating Infracost Cloud settings, see docs for other options.

──────────────────────────────────
53 cloud resources were detected:
∙ 9 were estimated
∙ 44 were free

┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━━━┳━━━━━━━━━━━━━┳━━━━━━━━━━━━┓
┃ Project                                            ┃ Baseline cost ┃ Usage cost* ┃ Total cost ┃
┣━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━━━╋━━━━━━━━━━━━━╋━━━━━━━━━━━━┫
┃ main                                               ┃          $876 ┃           - ┃       $876 ┃
┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━━━┻━━━━━━━━━━━━━┻━━━━━━━━━━━━┛
```