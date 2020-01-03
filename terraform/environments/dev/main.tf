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