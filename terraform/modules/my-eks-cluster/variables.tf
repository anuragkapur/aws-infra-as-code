variable "vpc-public-subnet-default" {
  type = string
  default = "dev-vpc-public-eu-west-1a"
}

variable "vpc-name" {
  type = string
  default = "dev-vpc"
}

variable "env-tag" {
  type = string
  default = "dev"
}

variable "eks_cluster_name" {
  default = "dev-eks-cluster"
}

variable "aws_credenital_profile" {
  default = "beancrunch"
}