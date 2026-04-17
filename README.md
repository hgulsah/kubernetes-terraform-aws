# Kubernetes Infrastructure on AWS with Terraform
Production-style Kubernetes infrastructure on AWS provisioned with Terraform, designed for repeatability, environment separation, and operational readiness.

## Overview
This project provisions a production-style Kubernetes platform on AWS using Terraform. The goal is to demonstrate automation-first infrastructure design with environment separation, repeatable provisioning, and operational readiness rather than a minimal demo setup.

## Tech Stack
- Terraform
- AWS
- Amazon EKS
- Kubernetes
- Amazon VPC
- S3
- DynamoDB
- AWS CLI
- kubectl

## Architecture
![Architecture Diagram](diagrams/AWS%20EKS%20Platform%20Architecture%20Provisioned%20with%20Terraform.png)

## Current Implementation
The current implementation includes:

- Terraform bootstrap for remote state infrastructure
- Amazon S3 backend for Terraform state
- DynamoDB table for state locking
- AWS VPC with public and private subnets across multiple Availability Zones
- Amazon EKS cluster provisioned with Terraform
- EKS managed node group for worker nodes
- Environment-based structure for infrastructure organization

## Platform Design
The platform is designed around the following components:

- AWS VPC with public and private subnets
- Amazon EKS as the managed Kubernetes control plane
- EKS managed node groups for worker nodes
- Terraform-managed infrastructure with reusable environment structure
- Remote state and locking for safer infrastructure workflows

## Design Decisions

### Infrastructure as Code as the Single Source of Truth
All infrastructure is defined declaratively in Terraform to improve consistency, traceability, and repeatability.

### Environment Separation
Infrastructure is organized by environment to reduce drift and support safer changes over time.

### Remote State with Locking
Terraform state is stored in S3 with DynamoDB locking to prevent concurrent modifications and improve workflow safety.

### Separation of Concerns
The project separates bootstrap infrastructure, core platform provisioning, and future application deployment workflows.

## Validation
After provisioning the infrastructure, I validated the environment by:

- updating kubeconfig with the AWS CLI
- confirming node readiness with `kubectl get nodes`
- verifying core system pods with `kubectl get pods -A`
- deploying an NGINX workload
- exposing the workload with a LoadBalancer Service
- confirming external access in the browser

## Validation Screenshots

### Node Ready
![kubectl get nodes](screenshots/01-kubectl-get-nodes.png)

### System Pods
![kubectl get pods -A](screenshots/02-kubectl-get-pods-all.png)

### Service Exposure
![kubectl get svc](screenshots/03-kubectl-get-svc.png)

### Browser Test
![nginx browser test](screenshots/04-nginx-browser.png)

## Challenges and Fixes
During the build, I encountered and resolved several practical issues:

- replaced an old S3 backend bucket from a previous AWS account with a new remote state backend
- cleaned up stale Terraform state from an earlier setup
- rebuilt AWS CLI authentication using a new AWS account and IAM user
- resolved EKS managed node group provisioning issues related to Kubernetes version and AMI compatibility
- validated cluster access and workload readiness using AWS CLI and kubectl
- configured GitLab CI/CD pipeline with AWS credentials as protected variables
- resolved Terraform variable input errors in CI by using a var-file
- resolved IAM permission issues for KMS and CloudWatch during pipeline apply

## CI/CD

The project includes a working GitLab CI/CD pipeline with the following stages:

- **validate** — runs `terraform fmt` and `terraform validate` without connecting to remote state
- **plan** — initializes backend, runs `terraform plan`, and saves the plan as an artifact
- **apply** — applies the saved plan with manual approval required
- **destroy** — tears down all infrastructure with manual approval required

## Security
Current and planned security practices include:

- private subnets for worker nodes
- IAM-based access control through AWS and EKS
- remote state protection through encryption and access controls
- future implementation of IAM Roles for Service Accounts (IRSA) for fine-grained workload permissions
- future integration with AWS Secrets Manager or AWS Systems Manager Parameter Store for secrets handling

## Observability
Planned observability improvements include:

- Prometheus for metrics collection
- Grafana dashboards for visibility
- centralized logging with Loki or ELK
- alerting with Alertmanager

## Repository Structure
```bash
terraform/
├── bootstrap/           # remote state backend resources
└── environments/
    └── dev/             # development environment infrastructure

diagrams/                # architecture diagrams
screenshots/             # validation screenshots
```

## Roadmap
- [x] Remote state backend (S3 + DynamoDB locking)
- [x] VPC implementation
- [x] EKS cluster
- [x] Managed node group
- [x] Sample workload deployment and browser validation
- [ ] IRSA configuration
- [x] GitLab CI pipeline for plan/apply/destroy workflow
- [ ] Observability stack (Prometheus / Grafana / Loki)
- [ ] GitOps extension with Argo CD

## Notes
This project is focused on production-style infrastructure patterns, including automation, environment separation, and operational safety. It is being extended incrementally as a portfolio-quality platform engineering project.
