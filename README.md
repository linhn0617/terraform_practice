# Terraform AWS Dual-layer Network Architecture

This project sets up a secure dual-subnet architecture on AWS using Terraform. It provisions a bastion host in a public subnet and a private EC2 instance accessible only through the bastion, ideal for environments with stricter access control requirements.

## Architecture Overview

- **VPC**: `10.0.0.0/16` with public and private subnets
- **Bastion Host**: In public subnet, allows SSH from the internet
- **Private Instance**: In private subnet, no public IP, only accessible via Bastion
- **NAT Gateway**: Allows outbound internet access for private subnet
- **Security Groups**:
  - Bastion: Allows SSH from `0.0.0.0/0`
  - Private: Allows SSH **only** from Bastion security group

## Prerequisites

- Install [Terraform](https://developer.hashicorp.com/terraform/downloads)
- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Create an SSH key pair (or use existing one):
  ```bash
  ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_rsa
  ```
### IAM User and AWS CLI Configuration

1. Log in to the [AWS Console](https://console.aws.amazon.com/)
2. Create an IAM user with programmatic access
3. Generate and note the following credentials:
   - **User name**: `<your_iam_user_name>`
   - **Console sign-in URL**: `<your_sign_in_url>`
   - **Access Key ID**: `<your_access_key_id>`
   - **Secret Access Key**: `<your_secret_access_key>`

Then configure AWS CLI locally:

```bash
aws configure
```

Enter your credentials and set the default region as:

```
Default region name: ap-southeast-2
Default output format: json
```


## Deployment Steps

```bash
# Initialize Terraform
terraform init

# Preview the changes
terraform plan

# Apply and provision infrastructure
terraform apply
```

## SSH Access Instructions

### SSH into Bastion Host
```bash
ssh -i ~/.ssh/id_rsa ubuntu@<Bastion Public IP>
```

### SSH into Private Host via Bastion (Jump Host)
```bash
ssh -i ~/.ssh/id_rsa -J ubuntu@<Bastion Public IP> ubuntu@<Private Internal IP>
```

Terraform will output these exact commands after deployment.

## Modules and Configuration

- Terraform AWS VPC Module: `terraform-aws-modules/vpc/aws` v5.1.2
- AWS Region: `ap-southeast-2` (Sydney)

## Notes

- **Do not commit** your private SSH key to version control
- Consider using IAM policies for access restriction
- This setup can be extended to include RDS, ALB, etc.