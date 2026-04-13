# Kubernetes Infrastructure on AWS with Terraform

## Overview
This project provisions a production-style Kubernetes platform on AWS using Terraform. The goal is to demonstrate automation-first infrastructure design with environment separation, repeatable provisioning, and operational readiness rather than a minimal demo setup.

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

## Architecture
The platform is designed around the following components:

- AWS VPC with public and private subnets
- Amazon EKS as the managed Kubernetes control plane
- EKS managed node groups for worker nodes
- Terraform-managed infrastructure with reusable environment structure
- Remote state and locking for safer infrastructure workflows

## Design Decisions

### Infrastructure as Code as the single source of truth
All infrastructure is defined declaratively in Terraform to improve consistency, traceability, and repeatability.

### Environment separation
Infrastructure is organized by environment to reduce drift and support safer changes over time.

### Remote state with locking
Terraform state is stored in S3 with DynamoDB locking to prevent concurrent modifications and improve workflow safety.

### Separation of concerns
The project separates bootstrap infrastructure, core platform provisioning, and future application deployment workflows.

## Validation
After provisioning the infrastructure, I validated the environment by:

- updating kubeconfig with the AWS CLI
- confirming node readiness with `kubectl get nodes`
- verifying core system pods with `kubectl get pods -A`
- deploying an nginx workload
- exposing the workload with a LoadBalancer service
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

## CI/CD Strategy
Planned GitLab CI/CD workflow:

- `terraform fmt` / `terraform validate`
- static analysis and security scanning with tools such as `tflint` and `tfsec`
- `terraform plan` for review in merge requests
- controlled `apply` with approval for higher-risk environments

## Security
Current and planned security practices include:

- private subnets for worker nodes
- IAM-based access control through AWS and EKS
- remote state protection through encryption and access controls
- future implementation of IAM Roles for Service Accounts (IRSA) for fine-grained workload permissions
- future integration with AWS Secrets Manager or SSM for secrets handling

## Observability
Planned observability improvements include:

- Prometheus for metrics collection
- Grafana dashboards for visibility
- centralized logging with Loki or ELK
- alerting with Alertmanager

## Repository Structure
- `terraform/bootstrap/` — bootstrap resources for remote state backend
- `terraform/environments/dev/` — development environment infrastructure
- `diagrams/` — architecture diagrams and supporting documentation assets
- `screenshots/` — validation screenshots from the running cluster

## Roadmap
- [x] Remote state backend (S3 + DynamoDB locking)
- [x] VPC implementation
- [x] EKS cluster
- [x] Managed node group
- [x] Sample workload deployment and browser validation
- [ ] IRSA configuration
- [ ] GitLab CI pipeline for plan/apply workflow
- [ ] Observability stack (Prometheus/Grafana/Loki)
- [ ] GitOps extension with Argo CD

## Notes
This project is focused on production-style infrastructure patterns, including automation, environment separation, and operational safety. It is being extended incrementally as a portfolio-quality platform engineering project.
