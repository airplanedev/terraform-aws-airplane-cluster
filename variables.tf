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

variable "labels" {
  type        = map(string)
  default     = {}
  description = "Labels to attach to agents which can be used to constrain what tasks the agent can accept"
}

// AWS variables

variable "agent_ami" {
  type = map(string)
  default = {
    "eu-west-1" = "ami-0344a57bbdbd737b1"
    "us-east-1" = "ami-0e447a549d06426a2"
    "us-west-2" = "ami-0b3925cb951f4a128"
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
