# terraform-aws-airplane-cluster

This terraform module creates an AWS ASG running Airplane agents.

To get started, you'll need an `api_token` and your `team_id`.

Use this module in your Terraform configuration:

```hcl
module "airplane_agent" {
  source  = "airplanedev/airplane-cluster/aws"
  version = "~> 0.4.0"

  api_token              = "YOUR_API_TOKEN"
  team_id                = "YOUR_TEAM_ID"
  # Set which VPC / subnets agents should live in
  vpc_subnet_ids         = ["subnet-000", "subnet-111"]

  # Optional settings:

  # Attach necessary IAM policies to e.g. allow agent to pull images from ECR
  managed_policy_arns    = [aws_iam_policy.agent.arn]
  # Additional security groups
  vpc_security_group_ids = ["sg-222"]
  # Change instance type (default t3.medium)
  instance_type = "t3.large"
}

resource "aws_iam_policy" "agent" {
  name_prefix = "airplane-agent-"
  path        = "/"
  description = "Policy for agents"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecr:GetAuthorizationToken",
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}
```
