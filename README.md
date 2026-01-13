# Kubernetes Infrastructure on AWS with Terraform

## Overview
This project provisions a production-style Kubernetes platform on AWS using Terraform.
The goal is to demonstrate automation-first infrastructure design with environment separation,
repeatable provisioning, and operational readiness (not a minimal demo setup).

## Architecture
> **Current state:** VPC and Terraform project structure are implemented.  
> **Planned:** EKS cluster, managed node groups, and IRSA will be provisioned incrementally.

- AWS VPC with public and private subnets
- Amazon EKS as the Kubernetes control plane
- Managed node groups for worker nodes
- IAM Roles for Service Accounts (IRSA) for secure AWS access
- Terraform-managed infrastructure (modular, version-controlled)

## Design Decisions
- Infrastructure as Code (Terraform) as the single source of truth
- Environment separation (dev / prod) to reduce drift and increase reliability
- Remote state + state locking (S3 + DynamoDB) to prevent concurrent changes
- Separation of concerns: infrastructure provisioning vs. application deployment

## CI/CD Strategy (Planned)
GitLab CI/CD will automate infrastructure workflows:
- `terraform fmt` / `validate`
- static analysis and security scanning (tflint, tfsec/trivy)
- `terraform plan` generated for merge request review
- controlled `apply` with manual approval for production

## Security (Planned)
- Least-privilege IAM and IRSA for Kubernetes workloads
- No long-lived AWS credentials inside the cluster
- Secrets managed via AWS Secrets Manager or SSM (future enhancement)

## Observability (Planned)
- Prometheus for metrics
- Grafana dashboards for visibility
- Centralized logging (Loki/ELK) to support debugging and incident response
- Alerting via Alertmanager

## Repository Structure
- `terraform/` : Terraform code (modules and environments)
- `diagrams/`  : Architecture diagrams and documentation assets

## Roadmap
- [ ] Remote state backend (S3 + DynamoDB locking)
- [ ] EKS module (cluster + node groups + IRSA)
- [ ] GitLab CI pipeline for plan/apply workflow
- [ ] GitOps with Argo CD for app delivery
- [ ] Observability stack (Prometheus/Grafana/Loki)

## Notes
- Focused on production realism: automation, security, and operational practices
- Designed to be extended incrementally as a portfolio-quality platform project
