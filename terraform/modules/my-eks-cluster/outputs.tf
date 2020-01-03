output "workers_asg_names" {
  description = "Names of the autoscaling groups containing workers."
  value = module.eks-cluster.workers_asg_names
}

