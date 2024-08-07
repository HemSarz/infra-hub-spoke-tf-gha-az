# Hub and Spoke infrastructure | Terraform | Azure | Github Actions
![Github Actions](https://img.shields.io/badge/Github%20Actions-%E2%9C%93-blue)
![Terraform](https://img.shields.io/badge/Terraform-IaaC-blue?logo=checkmarx)
![Azure](https://img.shields.io/badge/Azure-%E2%9C%93-blue)
![PowerShell](https://img.shields.io/badge/PowerShell-%E2%9C%93-blue)

This repository contains code and configurations to deploy a Hub-and-Spoke network architecture on Microsoft Azure using Terraform and GitHub Actions. Below is an overview of the repository's contents and their purposes:

## Table of Contents
- [Prerequisites](#prerequisites)
- [Folder Structure](#folder-structure)
- [Terraform Configuration](#terraform-configuration)
- [GitHub Actions Workflows](#github-actions-workflows)
- [Environment Configuration](#environment-configuration)
- [Getting Started](#getting-started)
### Prerequisites
Before you begin, ensure you have the following tools installed:

- VSCode or editor of your choice
- An Azure account with appropriate permissions
- Terraform
- GitHub CLI
- Azure CLI

## Folder Structure
The repository is organized as follows:
- `.github/workflows/`
- `terraform/`
  - `This folder contains an .tf file for each resource(nsg.tf etc)`
- `.env.backend`
- `.gitignore`
- `README.md`

## Terraform Configuration
### `terraform`
This directory contains the Terraform scripts necessary for deploying the Hub-and-Spoke network. The main configurations include:
- `main.tf`: Core infrastructure setup.
- `variables.tf`: Definitions of input variables.
- `outputs.tf`: Output values of the deployment.
- `providers.tf`: Azure provider configuration.

### Key Features
- **Hub-and-Spoke Topology**: The setup includes a central hub VNet connected to multiple spoke VNets.
- **Security**: Implements network security groups and other security measures.
- **Scalability**: Designed to easily add more spokes or modify existing configurations.

## GitHub Actions Workflows
### `.github/workflows/`
This directory contains GitHub Actions workflows that automate the deployment and management of the infrastructure.
- `deploy.yml`: Automates the deployment process using Terraform.
- `destroy.yml`: Automates the teardown process of the infrastructure.

### Key Features
- **CI/CD Integration**: Ensures continuous integration and deployment of infrastructure changes.
- **Automated Testing**: Validates configurations before deployment.

## Environment Configuration
### `.env.backend`
This file contains environment variables required for Terraform's backend configuration, such as Azure storage account details and container names for state management.

## Getting Started
To get started with deploying the infrastructure:
1. Clone the repository.
2. Ensure you have Terraform and GitHub CLI installed.
3. Create an SPN in Azure with Contributor role: Create SPN using AZ CLi
4. Create Github Secrets using the SPN values

## Create SPN using AZ CLi

### 1. Log in to Azure
````
az login
````
### 2. Create the SPN and assign Contributor role
````
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/{subscription-id}

````

### 3. Output
Save the output as you will need them to create Github Secrets
````
{
  "appId": "your-app-id",
  "displayName": "your-app-name",
  "password": "your-client-secret",
  "tenant": "your-tenant-id"
}
````
### 1. Create GH Secrets using GH CLI

Install GH CLI using choco or link:
````
- choco install gh
- `https://github.com/cli/cli/releases/download/v2.53.0/gh_2.53.0_windows_amd64.msi`
````
### 2. Authenticate to Github CLI

gh auth login

### 3. Set your repo env
````
REPO="your-username/your-repo"
````
### 4. Set GitHub secrets using the SPN values
Use the SPN values from earlier
````
gh secret set AZURE_CLIENT_ID --body "your-app-id" --repo $REPO
gh secret set AZURE_CLIENT_SECRET --body "your-client-secret" --repo $REPO
gh secret set AZURE_TENANT_ID --body "your-tenant-id" --repo $REPO
gh secret set AZURE_SUBSCRIPTION_ID --body "your-subscription-id" --repo $REPO
````
