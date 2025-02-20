# AWS VPC and EC2 Terraform Setup

This Terraform configuration sets up an AWS VPC, subnets, security groups, and EC2 instances. The infrastructure is designed for a web and database setup with public and private subnets, respective security groups, and automated provisioning using `null_resource`.

## Prerequisites

- **Terraform**: Ensure that Terraform is installed on your machine.
- **AWS Credentials**: You need to have AWS credentials configured. You can do this using the AWS CLI by running `aws configure` or setting environment variables (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`).

## Resources Created

### VPC

- **CIDR Block**: The VPC has a CIDR block defined in `vpc_info.cidr_block`. The default value is `10.0.0.0/16`.
- **Tags**: The VPC is tagged with the values from `vpc_info.tags`.

### Subnets

- **Web Subnets**: Two public subnets in different availability zones (`ap-south-1a` and `ap-south-1b`) for the web tier.
- **DB Subnets**: Two private subnets in different availability zones for the database tier.

### Security Groups

- **Web Security Group (`web-sg`)**: 
  - Allows inbound traffic on port 22 (SSH) and port 80 (HTTP) from any IP (`0.0.0.0/0`).
  - Allows all outbound traffic (egress).
  
- **DB Security Group (`db-sg`)**: 
  - Allows inbound MySQL traffic on port 3306.
  - Allows all outbound traffic (egress).

### Internet Gateway

- An Internet Gateway is attached to the VPC to enable internet access for resources in the public subnets.

### Route Tables

- **Public Route Table**: Associated with the web subnets, routing internet-bound traffic via the Internet Gateway.
- **Private Route Table**: Associated with the DB subnets for internal communication.

### EC2 Instances

- **Web Instance**: 
  - AMI: `ami-00bb6a80f01f03502`
  - Instance type: `t2.micro`
  - Key Pair: Defined by the `keypair` variable.
  - Public IP: The instance is assigned a public IP.
  - Tags: The instance is tagged as `web_instance`.

### Key Pair

- A new AWS key pair is created using the public key provided in `keypair.public_key`.

### Provisioning

- **Null Resource**: A script (`script.sh`) is executed on the web instance using an SSH connection once it is created and available. This script provisions the web server by installing Nginx and deploying a simple HTML site.

## Variables

### VPC Information


## subnets

```hcl

variable "vpc_info" {
  type = object({
    cidr_block = string
    tags       = map(string)
  })
}

variable "web_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
}

variable "db_subnets" {
  type = list(object({
    cidr_block        = string
    availability_zone = string
    tags              = map(string)
  }))
}

## security groups

variable "web_securitygroups" {
  type = object({
    name        = string
    description = string
    tags        = map(string)
  })
}

variable "db_securitygroups" {
  type = object({
    name        = string
    description = string
    tags        = map(string)
  })
}

## Key Pair

variable "keypair" {
  type = object({
    key_name   = string
    public_key = string
  })
}

## Instance Information

variable "instance_info" {
  type = object({
    ami                         = string
    instance_type               = string
    associate_public_ip_address = bool
    username                    = string
    tags                        = map(string)
  })
}

## Provisioning Script

The script.sh file is automatically executed on the web instance to provision a basic Nginx server and deploy a static website.

##Script Contents:

#!/bin/bash
sudo apt update
sudo apt install nginx -y
sudo apt install unzip -y
cd /tmp && wget https://www.free-css.com/assets/files/free-css-templates/download/page295/antique-cafe.zip
unzip /tmp/antique-cafe.zip
sudo mv /tmp/2126_antique_cafe/ /var/www/html/cafe/


What the Script Does:

Updates the System: Runs sudo apt update to ensure the package lists are updated.
Installs Nginx: Installs the Nginx web server.
Installs Unzip: Installs the unzip utility to extract the downloaded files.
Downloads HTML Template: Downloads a free static website template (antique-cafe.zip) from Free CSS.
Unzips the Template: Extracts the downloaded zip file.
Deploys the Template: Moves the extracted files to /var/www/html/cafe/ for Nginx to serve.
Once the script is executed, you can access the static website at the public IP of the web instance.

## How to Use

1. **Clone the Repository**:  
    Clone the repository containing this Terraform configuration.

    ```bash
    git clone <repository-url>
    cd <repository-directory>

2. Update Variables:
    Adjust the variables in the configuration to match your environment:

    VPC CIDR Block: Modify the vpc_info.cidr_block if needed.
    Subnets: Update the subnet CIDR blocks and availability zones in web_subnets and db_subnets to reflect your preferred AWS region and network setup.
    Key Pair: Ensure that keypair.key_name matches your AWS key pair and keypair.public_key points to the correct path for your public key.
    Instance Information: Ensure the instance_info (such as ami, instance_type, and tags) matches the EC2 instance specifications you wish to use. 

## Initialize Terraform

Before deploying the infrastructure, you need to initialize Terraform to download the necessary provider plugins and set up the working directory. Follow these steps:

1. **Navigate to the Directory**:  
   Change to the directory where your Terraform configuration files are located.

   ```bash
   cd <repository-directory>

Run Terraform Init:

Initialize the Terraform environment by running the following command. This will download the required provider plugins (e.g., AWS provider) and set up the backend.

bash
Copy
Edit
terraform init
You should see output indicating that the initialization was successful, and Terraform will be ready to execute further commands.

## Plan the Deployment:

terraform plan


## Apply the Configuration:
terraform apply

## Access the EC2 Instance:

ssh -i ~/.ssh/id_rsa ubuntu@<instance-public-ip>


## Access the Static Website:

Once the provisioning script is executed, you can access the static website hosted on the web instance by visiting http://<instance-public-ip>/cafe/ in your browser.

## Cleanup

terraform destroy






 
