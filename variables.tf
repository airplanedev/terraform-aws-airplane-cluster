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
  type = map(string)
  default = {
    "eu-west-1" = "ami-0d70cd08fa8d28277"
    "us-east-1" = "ami-091e1434b7783a4de"
    "us-west-2" = "ami-00e123e306c53ba0c"
  }
}

variable "instance_count" {
  type    = number
  default = 1
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

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "List of security group IDs to attach to instances"
  default     = []
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs to deploy instances into"
}
