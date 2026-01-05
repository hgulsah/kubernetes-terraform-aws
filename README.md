# Kubernetes Infrastructure on AWS with Terraform

## Overview
This project demonstrates how to provision a Kubernetes-ready infrastructure on AWS using Terraform.
The goal is to simulate a production-like environment focusing on scalability, reproducibility, and automation.

## Architecture
- AWS VPC with public and private subnets
- EC2 instances prepared for Kubernetes workloads
- Infrastructure provisioned and managed using Terraform

## Why Terraform?
Terraform allows infrastructure to be defined as code, making environments reproducible,
version-controlled, and easy to destroy or recreate.

## Kubernetes Layer
Kubernetes is used to orchestrate containerized applications on top of the provisioned AWS infrastructure.
Basic deployments and services are configured to validate cluster functionality.

## CI/CD (Planned)
- Infrastructure validation
- Automated deployment pipeline

## Observability (Planned)
- Metrics
- Logging
- Alerting

## What I Learned
- Designing cloud infrastructure using Terraform
- Preparing AWS resources for Kubernetes
- Common challenges when bootstrapping Kubernetes on AWS
