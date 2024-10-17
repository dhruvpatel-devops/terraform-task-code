# Terraform GCP Infrastructure Automation
This repository contains Terraform code to automate the creation of infrastructure on Google Cloud Platform (GCP), including:
- VPC (Virtual Private Cloud)
- Cloud Run (Managed serverless compute)
- Cloud SQL (Relational database service)
- Load Balancer (Google Cloud's load balancing service)
The infrastructure is deployed using a CI/CD workflow through GitHub Actions. The workflow uses a Google Cloud Service Account for authentication.
## Prerequisites
Before you start using this project, ensure you meet the following prerequisites:
### 1. Google Cloud Account
- You must have a Google Cloud account with sufficient permissions to create the necessary resources (VPC, Cloud Run, Cloud SQL, and Load Balancer).
- A project must be created in GCP to host these resources.
### 2. Service Account with Required Permissions
- Create a Service Account in GCP with the necessary roles to provision infrastructure:
    - `roles/compute.Admin` (for VPC creation)
    - `roles/run.admin` (for Cloud Run management)
    - `roles/cloudsql.admin` (for Cloud SQL management)
    - `roles/iam.serviceAccountUser` (to manage service accounts)
    - `roles/storage.admin` (if needed for Cloud Storage interaction)
    - `roles/compute.loadBalancerAdmin` (for Load Balancer creation)
### 3. Service Account Key (JSON)
- Download the Service Account key in JSON format. This key will be used by GitHub Actions to authenticate with GCP.
- Save this key as a GitHub Secret in your repository.
### 4. GitHub Secrets Configuration
To securely store the Service Account key, follow these steps:
1. In your GitHub repository, navigate to `Settings > Secrets and variables > Actions > New repository secret`.
2. Add the following secret:
    - `TEST_CICD_SA`: Paste the content of your service account JSON file here.
## CI/CD Workflow
The project includes a GitHub Actions workflow (`.github/workflows/create-resources.yml`) to automate Terraform operations. This workflow runs in the GCP, meaning no local installation of Terraform or Google Cloud SDK is required.
