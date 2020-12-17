# terraform-aws-airplane-cluster

This terraform module creates an AWS ASG running Airplane agents.

To get started, you'll need an `api_token` and your `team_id`.

Use this module in your Terraform configuration:

```
module "airplane_agent" {
  source                 = "github.com/airplanedev/terraform-aws-airplane-cluster@v0.1"

  api_token              = "YOUR_API_TOKEN"
  team_id                = "YOUR_TEAM_ID"

  vpc_subnet_ids         = ["subnet-000", "subnet-111"]
  vpc_security_group_ids = ["sg-222"]
}
```
