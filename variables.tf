
variable "region" {
  type        = string
  description = "The AWS region to deploy to"
  default     = "us-west-2"
}

variable "default_tag" {
  type        = string
  description = "A default tag to add to everything"
  default     = "terraform_aws_vpc"
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "application_name" {
  description = "The name of the application"
  type        = string
}