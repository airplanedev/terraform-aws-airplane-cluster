variable "agent_ami" {
  type = map
  default = {
    "us-west-2" = "ami-06040278af81a8aac"
    // TODO: add us-east-1, eu-west-1, us-east-2, us-west-1
  }
}

variable "api_host" {
  type    = string
  default = "https://api.airplane.dev"
}

variable "api_token" {
  type = string
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "team_id" {
  type = string
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "vpc_security_group_ids" {
  type        = list
  description = "List of security group IDs to apply to instances"
}

variable "vpc_subnet_ids" {
  type        = list
  description = "List of subnet IDs to deploy instances into"
}
