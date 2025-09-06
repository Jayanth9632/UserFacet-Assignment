# UserFacet Assignment
This Assignment project deploys a containerized **React application** on EC2 and exposes it using the NGINX web server.

##  Infrastructure Overview

This project creates:
- **EC2 Instance** running Ubuntu 22.04 LTS
- **Security Groups** with controlled access for SSH, HTTP, and Jenkins
- **Jenkins CI/CD Server** accessible on port 8080
- **Docker Engine** for containerized applications
- **Nginx Web Server** for reverse proxy and web hosting

##  Project Structure

```
terraform/
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Variable definitions
├── outputs.tf              # Output values
├── terraform.tfvars        # Variable values (customize this!)
├── .gitignore              # Git ignore rules
└── modules/
    └── ec2-jenkins-docker-nginx/
        ├── main.tf         # EC2 instance and security group
        ├── variables.tf    # Module variables
        ├── outputs.tf      # Module outputs
        └── userdata.tpl    # Bootstrap script for instance
```

##  Quick Start

### Prerequisites

1. **AWS Account** with appropriate permissions
2. **Terraform** installed (version >= 1.5.0)
3. **AWS CLI** configured with your credentials
4. **EC2 Key Pair** created in your target AWS region

### Step 1: Configure AWS Credentials

```bash
# Option 1: AWS CLI
aws configure

# Option 2: Environment Variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### Step 2: Customize Configuration

Edit `terraform.tfvars` file with your specific values:

```hcl
region               = "us-east-1"           # Your preferred AWS region
key_name             = "your-key-pair-name"  # Your EC2 key pair name
allowed_ssh_cidr     = "YOUR.IP.ADDRESS/32"  # Your public IP for SSH access
allowed_jenkins_cidr = "YOUR.IP.ADDRESS/32"  # Your public IP for Jenkins access
instance_type        = "t3.small"           # Instance size (adjust as needed)
volume_size_gb       = 20                   # Root disk size in GB
```

**Important:** Replace `YOUR.IP.ADDRESS` with your actual public IP address. You can find it by visiting [whatismyip.com](https://whatismyip.com)

### Step 3: Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Review the execution plan
terraform plan

# Apply the configuration
terraform apply
```

Type `yes` when prompted to confirm the deployment.

### Step 4: Access Your Services

After successful deployment, Terraform will output the connection details:

```bash
# SSH into your instance
ssh -i /path/to/your-key.pem ubuntu@<EC2_PUBLIC_IP>

# Access Jenkins Web UI
http://<EC2_PUBLIC_IP>:8080

# Access Nginx (if configured)
http://<EC2_PUBLIC_IP>
```

##  What Gets Installed

The EC2 instance is automatically configured with:

- **Jenkins**: Latest LTS version with initial setup
- **Docker**: Latest stable version with docker-compose
- **Nginx**: Latest stable version
- **Git**: For source code management

##  Post-Deployment Steps

### 1. Complete Jenkins Setup

1. SSH into your instance and retrieve the initial admin password:
   ```bash
   sudo cat /var/lib/jenkins/secrets/initialAdminPassword
   ```

2. Access Jenkins at `http://<EC2_PUBLIC_IP>:8080`
3. Enter the initial admin password
4. Install suggested plugins
5. Create your first admin user

##  Cleanup

To destroy all created resources:

```bash
terraform destroy
```

Type `yes` when prompted to confirm the destruction.

---

# Jenkins CI/CD Pipeline for React Application Deployment

## Overview
This Jenkins pipeline automates the deployment of a React application using Docker and Nginx as a reverse proxy. The pipeline clones a repository, builds a Docker image, runs the container, and configures Nginx to serve the application.

## Pipeline Stages

### 1. Clone Repository
- **Purpose**: Downloads the source code from the specified Git repository
- **Action**: Clones the `main` branch from `https://github.com/dewanshuf/aws-project`

### 2. Ensure Dockerfile Exists
- **Purpose**: Creates a Dockerfile if it doesn't exist in the repository
- **Action**: 
  - Checks for existing Dockerfile
  - If not found, creates a multi-stage Dockerfile that:
    - Uses Node.js 20 Alpine as base image
    - Installs dependencies and builds the React app
    - Creates a production image with `serve` to host static files
    - Exposes port 3000

### 3. Build Docker Image
- **Purpose**: Creates a Docker image from the Dockerfile
- **Action**: Builds an image tagged as `react-app:latest`

### 4. Run Container
- **Purpose**: Deploys the application in a Docker container
- **Action**: 
  - Removes any existing container with the same name
  - Runs a new container exposing port 3000

### 5. Configure Nginx
- **Purpose**: Sets up Nginx as a reverse proxy to serve the application on port 80
- **Action**: 
  - Creates Nginx server configuration
  - Sets up proxy to forward requests to the Docker container
  - Enables the site and restarts Nginx

## Post-Build Actions
- **Success**: Displays success message with application URL
- **Failure**: Displays failure notification

## Log Files
The Jenkins build logs and execution details can be found in the Jenkins folder as this pipeline configuration.

##  Hardcoded Values That Should Be Dynamic

The following values are currently hardcoded and should be made configurable for production use:

### Environment Variables (Currently Hardcoded)
```groovy
environment {
    APP_NAME = "react-app"           // Should be configurable
    APP_PORT = "3000"               // Should be configurable
    PUBLIC_IP = "54.146.235.126"    // Should be dynamic or from environment
}
```

### Git Repository (Hardcoded)
```groovy
git branch: 'main', url: 'https://github.com/dewanshuf/aws-project'
```
