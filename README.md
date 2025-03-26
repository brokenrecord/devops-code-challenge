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