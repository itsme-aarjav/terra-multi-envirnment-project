# AWS Infrastructure Automation with Terraform

Terraform configurations to provision AWS infrastructure for Development, Staging, and Production environments.

## Architecture

- **Compute**: EC2 instances running Ubuntu 22.04 LTS, key pair (`terra-key`), and automated Nginx installation via user data.
- **Storage**: S3 bucket per environment with prefix-based naming.
- **Database**: DynamoDB table with on-demand (PAY_PER_REQUEST) billing.
- **Security**: Security group allowing inbound HTTP (port 80) and SSH (port 22).

## Environment Specifications

| Environment | Variable File | EC2 Instances | Instance Type | S3 Bucket | DynamoDB Table |
|---|---|---|---|---|---|
| Development | `dev.tfvars` | 1 | t2.micro | Yes | Yes |
| Staging | `staging.tfvars` | 1 | t2.small | Yes | Yes |
| Production | `prod.tfvars` | 2 | t2.medium | Yes | Yes |

## Project Structure

```text
infra-app/
├── provider.tf          # Provider setup (AWS)
├── variables.tf         # Variable declarations
├── ec2.tf               # EC2 and security group resources
├── s3.tf                # S3 bucket resource
├── dynamodb.tf          # DynamoDB table resource
├── outputs.tf           # Output values
├── install_nginx.sh     # User data startup script
├── dev.tfvars           # Development environment variables
├── staging.tfvars       # Staging environment variables
└── prod.tfvars          # Production environment variables
```

## Deployment Instructions

### 1. Initialize Terraform
```bash
terraform init
```

### 2. Deploy an Environment
To deploy the development environment:
```bash
terraform plan -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

For staging:
```bash
terraform plan -var-file="staging.tfvars"
terraform apply -var-file="staging.tfvars"
```

For production:
```bash
terraform plan -var-file="prod.tfvars"
terraform apply -var-file="prod.tfvars"
```

### 3. Verify Deployment
Once apply finishes, Terraform prints the public IP addresses and web URLs for accessing the Nginx server in a browser:
```text
Outputs:

ec2_public_ips = [
  "x.x.x.x",
]
nginx_urls = [
  "http://x.x.x.x",
]
```

### 4. SSH into Instance
Use the `terra-key` private key to connect:
```bash
ssh -i terra-key ubuntu@<ec2-public-ip>
```

### 5. Cleanup
To destroy resources and prevent ongoing AWS charges:
```bash
terraform destroy -var-file="dev.tfvars"
```
