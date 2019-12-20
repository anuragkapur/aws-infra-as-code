AWS - Infra as code
===================

This repository contains infrastructure code I use to manage my AWS account.

## Pre-requisites
* Terraform 0.12
* Ansible 2.5.2
* [aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)

### Infra setup using terraform
1. Create new AWS account
1. Create new IAM user with admin privileges and add the access key ID and secret access key to `~/.aws/credentials`
1. Ensure there are no `AWS_ACCESS_KEY` or `AWS_SECRET_KEY` env variables defined in your local env
1. Review configuration variables in [dev-env.tfvars](./terraform/dev-env.tfvars), especially, `aws_credenital_profile`
variable
1. Provision infrastructure
    ```shell script
    cd terraform
    terraform init
    terraform apply -var-file="dev-env.tfvars"
    ```

### Local client setup
1. Configure the path of the [kubeconfig_dev-eks-cluster](./terraform/kubeconfig_dev-eks-cluster) in the `KUBECONFIG` 
env variable for your local environment to be able to communicate with the EKS cluster using `kubectl`


