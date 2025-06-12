Provision an AWS infrastructure using Terraform that hosts a static website on an EC2 instance running Nginx. The website content is stored in a private S3 bucket and fetched by the EC2 instance.

## Features

- VPC with a public subnet
- Internet Gateway and Route Table
- Security Group with HTTP and SSH access
- S3 bucket for hosting static assets
- IAM Role and Policy for EC2 to access S3
- EC2 instance (Ubuntu) with public IP
- Automatically fetches `index.html` from S3
- Fully deployed using Terraform

## How to Run

### 1. Prerequisites

- AWS CLI configured
- Terraform ≥ 1.3
- SSH key pair in AWS (update key_name variable)

### 2. Deploy Infrastructure

```bash
terraform init
terraform apply
```

This will:

- Create all required AWS resources
- Upload index.html to S3
- Launch an EC2 instance
- Configure Nginx to serve the HTML from S3

### 3. Access the Webpage

After apply completes, Terraform will output the public IP. Open it in your browser:
http://<ec2-public-ip>
You should see your index.html.

## Security Notes
- EC2 can access S3 via IAM Role
- S3 is private; not publicly accessible
- Only port 80 (HTTP) and 22 (SSH) are open

## Author
Gergő Tóth – [GitHub Profile](https://github.com/tothgergo200)