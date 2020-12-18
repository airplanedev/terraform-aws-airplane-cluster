data "aws_region" "current" {}

resource "aws_launch_template" "lt" {
  name_prefix            = "airplane-agent-"
  image_id               = var.agent_ami[data.aws_region.current.name]
  instance_type          = var.instance_type
  vpc_security_group_ids = var.vpc_security_group_ids

  iam_instance_profile {
    name = aws_iam_instance_profile.profile.name
  }

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
  name = "airplane-agent-${aws_launch_template.lt.latest_version}"

  vpc_zone_identifier = var.vpc_subnet_ids

  termination_policies = ["OldestInstance"]
  desired_capacity     = 1
  min_size             = 1
  max_size             = 5

  launch_template {
    id      = aws_launch_template.lt.id
    version = "$Latest"
  }

  lifecycle {
    create_before_destroy = true
  }
}
