// Airplane variables

variable "api_host" {
  type    = string
  default = "https://api.airplane.dev"
}

variable "api_token" {
  type = string
}

variable "team_id" {
  type = string
}

// AWS variables

variable "agent_ami" {
  type = map
  default = {
    "us-east-1" = "ami-0db2b54027b437e42"
    "us-west-2" = "ami-0e5a521c43f585d81"
    // TODO: add eu-west-1, us-east-2, us-west-1
  }
}

variable "aws_region" {
  type    = string
  default = "us-west-2"
}

variable "instance_type" {
  type    = string
  default = "t3.medium"
}

variable "managed_policy_arns" {
  type        = list(string)
  default     = []
  description = "List of IAM policy ARNs to attach to the instance role"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to apply to instances"
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to deploy instances into"
}
