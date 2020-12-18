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
    "us-east-1" = "ami-0efe4f802725e5849"
    "us-west-2" = "ami-0e5a521c43f585d81"
    "eu-west-1" = "ami-0107017f5252ef416"
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
