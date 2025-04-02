> ** Solution below! ** [Jump to Solution](#solution) **

---

# 🚀 DevOps Technical Challenge: FastAPI on ECS + Postgres RDS

Welcome, engineer! This challenge will test your ability to provision infrastructure, deploy applications, and handle secure configuration — all with modern AWS tooling and automation.

Your mission is to deploy a FastAPI app to **AWS ECS (Fargate)** that connects to a **PostgreSQL RDS** instance, with infrastructure defined via Terraform and deployments automated with GitHub Actions.

---

## 🎯 Goal

Build and deploy a simple FastAPI application that:
- Runs on ECS Fargate
- Connects to a managed Postgres RDS database
- Is accessible via a public Load Balancer
- Retrieves and displays a random greeting from the DB on `/hello`

---

## 📦 What We Provide

- A base Terraform project that provisions:
  - ✅ VPC with public subnets
  - ✅ ECS Cluster (Fargate)
  - ✅ Application Load Balancer (ALB)
  - ✅ IAM roles and security groups

- A container-ready FastAPI app under `app/`
- A `Makefile` and `docker-compose.yml` for local development and testing

> 🔧 **Note:** The ECS Task Definition and Service are **not included**. You will define and deploy them as part of this challenge.

---

## 🧠 What You’ll Need to Do

### 🛠 Infrastructure
- Add Terraform resources to provision:
  - ✅ PostgreSQL RDS instance
  - ✅ Secrets management for DB credentials (e.g., AWS Secrets Manager, SSM Parameter Store)

### 🚀 Application Deployment
- Build the FastAPI Docker image
- Push it to Amazon ECR
- Create and configure:
  - ✅ ECS Task Definition
  - ✅ ECS Service
  - ✅ Secure environment variable injection
- Wire the app to the existing ALB

### 🔁 CI/CD
- Create a GitHub Actions pipeline that:
  - Builds and pushes the Docker image
  - Triggers the ECS service update

### ✅ Validation
- Visit the ALB DNS and access `/hello`
- It should return a random message pulled from the database

---

## 📂 Deliverables

- ✅ GitHub repo containing:
  - Terraform code (including ECS + RDS)
  - FastAPI app with Dockerfile and SQL
  - GitHub Actions workflow
  - `README.md` files with clear setup & deployment instructions

---

## 🧪 Evaluation Criteria

| Category        | What We're Looking For                                         |
|----------------|------------------------------------------------------------------|
| **IaC**         | Terraform modularity, outputs, security groups, naming          |
| **RDS Setup**   | Secure DB placement, no public exposure                         |
| **Secrets**     | Use of Parameter Store or Secrets Manager                       |
| **CI/CD**       | Clean GitHub Actions pipeline, good naming and structure        |
| **Logging**     | Application and ECS logs accessible via CloudWatch              |
| **Clarity**     | Well-written and structured code and documentation              |

---

## 💡 Bonus (Optional - Show Your Seniority!)

If you want to go the extra mile, here are some enhancements that demonstrate deeper DevOps maturity:

| Bonus Feature            | Why It Matters                                           |
|--------------------------|-----------------------------------------------------------|
| 🔒 **HTTPS on ALB**      | Implement TLS termination (ACM cert + HTTPS listener)     |
| 🔐 **Secrets Manager**   | Inject DB creds securely instead of plain env vars         |
| 🔍 **CloudWatch Alarms** | Add basic health checks or CPU/memory alarms for ECS      |
| 📊 **Dashboards**        | Set up a simple CloudWatch dashboard                      |
| 🚫 **Restrict Access**   | Limit RDS to only app subnet/security group               |
| 🧪 **Test Endpoint**     | Add a `/health` endpoint for uptime monitoring             |
| 🔄 **Blue/Green Deploy** | Use CodeDeploy or service update strategy for zero-downtime |

None of these are required, but they will help us gauge your senior-level understanding of infrastructure and operations.

---

## 🧰 Getting Started

```bash
# clone the repo
git clone <your-fork-url>

# navigate to infra and initialize
cd terraform/infra
terraform init
terraform apply

# navigate to app for local testing
cd app
make up
curl localhost:8000/hello
```

Then head to GitHub Actions and AWS Console to continue deployment steps.

---

## 🧼 Clean-Up Reminder
Don't forget to destroy your AWS resources after completing the challenge:
```bash
cd terraform/infra
terraform destroy
```

---

## 🙌 Good Luck
We're excited to see your solution. Show us how you'd approach this in the real world! 🧠⚙️💥

---

## Solution

### Deployment Guide

Steps to deploy the solution using Terraform and trigger the application deployment via GitHub Actions.

### 0. Prerequisites

1. Ensure Terraform CLI is installed. ([Installation Guide](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli))
1. Ensure AWS CLI is installed. ([Installation Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
1. Configure your environment for AWS authentication for use with the Terraform AWS provider

    - _Example:_ If using AWS IAM Identity Center: `aws sso login`
    - Ensure the credentials have permissions to create resources

### 1. Infrastructure (Terraform)

1. Clone (or fork) the repository:

    - You'll need your own copy of this repo to run the Github Action

    ```bash
    git clone <repository-url>
    cd <repository-name>
    ```

1. Initialize Terraform:

    ```bash
    # Ensure you are in the terraform/infra directory
    terraform init
    ```

1. Apply Terraform:

    Create the AWS resources:

    - Provide the `github_repo` variable (or set it in `terraform.tfvars`), specifying **your** own copy of this repo

    ```bash
    # Ensure you are in the terraform/infra directory
    terraform apply -var "github_repo=brokenrecord/devops-code-challenge" # Replace with your repo details
    ```

On success, the necessary AWS infrastructure is provisioned. The ECS service is ready but waiting for a container image to be deployed to ECR.

### 2. Container (GHA CI/CD)

The container deployment is handled by a GitHub Actions workflow. This workflow needs information from the Terraform state to authenticate with AWS and deploy to the correct resources.

1. Trigger the workflow

    To provide the necessary infrastructure details to the workflow for this solution, we commit the `terraform.tfstate` file.

    ```bash
    git add terraform.tfstate
    git commit -m "commit terraform.tfstate"
    git push origin main
    ```

    Note on `terraform.tfstate`:

    - Obviously, committing the tfstate to version control is **discouraged** in production or team environments. It can contain sensitive information and creates risks for state locking and conflicts when multiple people run Terraform.
    - For this solution, I decided on committing the state file as a demonstration to allow the GitHub Action to easily access output values required for deployment **without** having you setup any GHA secret management or Terraform state backend configurations.
    - In a real-world scenario, You'd use a Terraform remote state backend (like AWS S3 with DynamoDB locking) and pass values to the CI/CD pipeline via secure mechanisms like GitHub secrets.

2. GitHub Action

   Pushing the commit to `main` triggers the `deploy.yml` workflow, which:

    - Checks out the code.
    - Uses GitHub's OIDC provider to authenticate with AWS by assuming the IAM role created by Terraform (`__gha_gha_role_arn` output).
    - Builds the Docker image located in the `app/` directory.
    - Pushes the built Docker image to the AWS ECR repository created by Terraform (`__gha_ecr_repository` output).
    - Updates the AWS ECS service (`__gha_ecs_service` output) within the cluster (`__gha_ecs_cluster` output) to use the new Docker image, triggering a new deployment task.

### 3. Accessing the Application and Monitoring

1. **Wait for deployment**. Allow a few minutes for the GitHub Action to complete, the ECS service to pull the new image, and the new task to become healthy and register with the Load Balancer (Target Group).

2. Get the public URL of the deployed application from the Terraform output:

    ```bash
    # Ensure you are in the terraform/infra directory
    terraform output url
    ```

    Access the printed URL in your browser.

3. (optional) Get the CloudWatch Dashboard created by Terraform to monitor the health and performance metrics of the application and infrastructure:

    ```bash
    # Ensure you are in the terraform/infra directory
    terraform output url_dashboard
    ```

    Access the printed URL in your browser.

### 4. Cleanup

To remove all deployed resources, run the following command:

```bash
# Ensure you are in the terraform/infra directory
terraform destroy -var 'github_repo=brokenrecord/devops-code-challenge' # Replace with your repo details
```
