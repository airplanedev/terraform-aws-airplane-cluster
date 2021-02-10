data "aws_region" "current" {}

data "aws_subnet" "subnet" {
  id = var.vpc_subnet_ids[0]
}

module "agent_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "airplane-agent"
  description = "Security group for Airplane agent"
  vpc_id      = data.aws_subnet.subnet.vpc_id

  egress_rules = ["all-all"]
}

resource "aws_launch_template" "lt" {
  name_prefix            = "airplane-agent-"
  image_id               = var.agent_ami[data.aws_region.current.name]
  instance_type          = var.instance_type
  vpc_security_group_ids = concat([module.agent_sg.this_security_group_id], var.vpc_security_group_ids)

  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

  instance_initiated_shutdown_behavior = "terminate"

  user_data = base64encode(templatefile("${path.module}/userdata.tpl", {
    api_host  = var.api_host
    api_token = var.api_token
    team_id   = var.team_id
  }))
}

resource "aws_iam_instance_profile" "profile" {
  name_prefix = "airplane-agent-"
  role        = aws_iam_role.role.name
}

resource "aws_iam_role" "role" {
  name_prefix = "airplane-agent-"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "attach" {
  count      = length(var.managed_policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = var.managed_policy_arns[count.index]
}

resource "aws_autoscaling_group" "asg" {
  name_prefix = "airplane-agent-"

  vpc_zone_identifier = var.vpc_subnet_ids

  termination_policies = ["OldestInstance"]
  desired_capacity     = var.instance_count
  min_size             = var.instance_count
  max_size             = var.instance_count

  launch_template {
    id      = aws_launch_template.lt.id
    version = aws_launch_template.lt.latest_version
  }

  lifecycle {
    create_before_destroy = true
  }

  dynamic "tag" {
    for_each = var.tags
    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }

  // Whenever template, tags, etc. change, trigger an instance refresh
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 100
    }
    triggers = ["tag"]
  }
}
