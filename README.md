# AWS Infra

### Create AWS Infrastructure using Terraform

### Table of contents

- Prerequisites
- Terraform Initialize and apply

### Prerequisites

## AWS CLI

- Make sure you install the latest AWS CLI v2. Kindly visit [AWS CLI Website](https://aws.amazon.com/cli/) for installation instructions
- When you are done with the installation, please run the following command to verify whether the aws cli is working
  - `aws --version`
- If you have successfully installed, please acquire the security credentials from AWS IAM. You can able to set the profile using
  - `aws configure --profile <profile-name>`

## Terraform

- Terraform is the IaaC tool offered by Hashicorp. Kindly visit [Terraform](https://www.terraform.io/) for details
- Download and install the [Terraform CLI](https://developer.hashicorp.com/terraform/downloads?product_intent=terraform)
- Verify whether you have correctly installed Terraform by running this command
  - `terraform -version`

### Implementing the Infrastructure using Terraform

- Clone the repository
- Initialize the Terraform repo using the following command
  - `terraform init`
- In this repo, I've given the default region and default profile as "us-east-1" and "dev", if you want to give other values, make sure you create and initialize the variables inside the **.tfvars** file
- In order to see if there are any syntax errors and observe which services will be added, run the following command
  - `terraform plan`
- Now, in order to implement them to AWS, please run the following command
  - `terraform apply --auto-approve`
  - Adding --auto-approve tag will disable asking for the confirmation prompt
- In order to remove the resources from AWS, please run the following command
  - `terraform destroy --auto-approve`
- It is advisable to create any (file-name).tfvars and initialize the variables inside it. In order to include this tfvar file while applying the resources, please add --var-file="<(file-name)>.tfvars"
  - Eg:
    - `terraform apply --auto-approve -var-file="<file-name>.tfvars"`
    - `terraform destroy --auto-approve -var-file="<file-name>.tfvars"`

## Nothing to see here
