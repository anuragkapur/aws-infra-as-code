module "eks-cluster" {
  source             = "terraform-aws-modules/eks/aws"
  cluster_name       = "${var.eks_cluster_name}"
  subnets            = concat(module.vpc.public_subnets, module.vpc.private_subnets)
  vpc_id             = "${module.vpc.vpc_id}"
  kubeconfig_aws_authenticator_env_variables = {
    AWS_PROFILE = "${var.aws_credenital_profile}"
  }

  worker_groups = [
    {
      name                 = "on-demand-1"
      instance_type        = "t3.medium"
      asg_min_size         = 0
      asg_max_size         = 3
      asg_desired_capacity = 0
      autoscaling_enabled  = true
      kubelet_extra_args   = "--node-labels=kubernetes.io/lifecycle=normal"
      suspended_processes  = ["AZRebalance"]
    },
    {
      name                 = "spot-1"
      spot_price           = "0.0456"
      instance_type        = "t3.medium"
      asg_min_size         = 1
      asg_max_size         = 5
      asg_desired_capacity = 1
      autoscaling_enabled  = true
      kubelet_extra_args   = "--node-labels=kubernetes.io/lifecycle=spot"
      suspended_processes  = ["AZRebalance"]
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "${var.env-tag}"
  }
}