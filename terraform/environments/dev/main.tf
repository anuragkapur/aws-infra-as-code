provider "aws" {
  region = "eu-west-1"
  shared_credentials_file = "~/.aws/credentials"
  profile = "beancrunch"
}

module "my-eks-cluster" {
  source = "../../modules/my-eks-cluster"

  vpc-public-subnet-default="dev-vpc-public-eu-west-1a"
  vpc-name="dev-vpc"
  env-tag="dev"
  aws_credenital_profile="beancrunch"
}

resource "aws_autoscaling_schedule" "evening-stop" {
  count                  = 2
  scheduled_action_name  = "asg-evening-stop-schedule.${count.index}"
  min_size               = "0"
  max_size               = "0"
  desired_capacity       = "0"
  recurrence             = "0 19 * * *"
  autoscaling_group_name = "${module.my-eks-cluster.workers_asg_names[count.index]}"
}

resource "aws_autoscaling_schedule" "morning-start" {
  count                  = 2
  scheduled_action_name  = "asg-morning-start-schedule.${count.index}"
  min_size               = "1"
  max_size               = "5"
  desired_capacity       = "1"
  recurrence             = "0 8 * * MON-FRI"
  autoscaling_group_name = "${module.my-eks-cluster.workers_asg_names[count.index]}"
}