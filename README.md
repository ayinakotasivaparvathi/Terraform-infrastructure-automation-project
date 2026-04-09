# Terraform-infrastructure-automation-project
# 🚀 Terraform Infrastructure Automation on AWS

This project demonstrates how to automate AWS infrastructure using Terraform by creating a complete environment including networking and compute resources, and deploying a live web server.

---

## 📌 Project Overview

In this project, I used Terraform (Infrastructure as Code) to provision AWS resources such as VPC, Subnet, Internet Gateway, Route Table, Security Group, and EC2 Instance. I also connected to the EC2 instance and deployed a web server using Nginx.

---

## 🛠 Technologies Used

- Terraform  
- AWS (EC2, VPC, Subnet, Internet Gateway, Security Groups)  
- Git & GitHub  

---

## ⚙️ Step-by-Step Implementation

### 🔹 Step 1: Install Tools

- Installed Terraform  
- Installed AWS CLI  

---

### 🔹 Step 2: Configure AWS CLI

Used AWS CLI to authenticate with AWS using IAM credentials.

```bash
aws configure

Provided:

Access Key ID
Secret Access Key
Region (us-east-1)
Output format (json)

Step 3: Create Terraform Project

Created project folder and files:

provider.tf
main.tf
variables.tf
outputs.tf


Step 4: Provider Configuration

Configured AWS provider:

provider "aws" {
  region = "us-east-1"
}

Step 5: Write Infrastructure Code

Defined resources in main.tf:

Created VPC
Created Public Subnet
Attached Internet Gateway
Configured Route Table
Created Security Group (SSH & HTTP access)
Fetched latest Amazon Linux AMI dynamically
Launched EC2 instance

Step 6: Initialize Terraform
terraform init
Downloads required providers
Prepares working directory

Step 7: Preview Infrastructure
terraform plan
Shows resources to be created
Validates configuration

Step 8: Apply Configuration
terraform apply
Creates AWS resources
Launches EC2 instance
Outputs public IP

Step 9: Connect to EC2 (SSH)
ssh -i my-key.pem ec2-user@<public-ip>

Step 10: Install Nginx
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx

Step 11: Deploy Web Page
echo "<h1>Hello Paru 🚀</h1>" | sudo tee /usr/share/nginx/html/index.ht

Step 12: Access Website

Opened in browser:

http://<public-ip>

Successfully hosted live web page.

Step 13: Push Code to GitHub
Initialized Git repository
Added project files
Created repository on GitHub
Pushed code
🔹 Step 14: Cleanup Resources
terraform destroy
Deleted all AWS resources to avoid billing
🏗 Architecture

This project follows a simple AWS architecture:

VPC (network boundary)
Public Subnet
Internet Gateway for connectivity
Route Table for traffic routing
Security Group for access control
EC2 instance hosting Nginx web server


📸 Screenshots
Terraform Apply Output
EC2 Running Instance
Security Group Rules
SSH Connection
Live Website Output

🎯 Key Learnings
Infrastructure as Code (IaC) using Terraform
AWS networking concepts (VPC, Subnet, Routing)
EC2 instance management
Security group configuration
Web server deployment
Version control using GitHub

Conclusion

This project helped me understand real-world cloud infrastructure automation and DevOps practices by deploying a fully functional web server using Terraform and AWS.






