# Pro2type
Tool for GitOps environment provisioning on Digital Ocean

# Default Requirements:

Digital Ocean account
Terraform Cloud account
Digital Ocean access token set to DO_API_TOKEN repository secret
Terraform Cloud access token set to TF_API_TOKEN repository secret
Set workflow permissions to read/write for your repository

# Installation:
To install from github you can go to action and manually start the Install workflow

This will create a Kubernetes cluster in Digital Ocean, then install ArgoCD and Crossplane on the cluster.

# Crossplane providers:
By default only the Digital Ocean Crossplane provider is added. 

# Applications:
For each application we will be developing a new ArgoCD application will be created through the dispatcher
Start the Add App workflow in Github Actions and provide the name for the application

# Resources:
Start the Add ApResource workflow in Github Actions and provide the name, type and application for the resource

# Inspiration
https://open.spotify.com/episode/50o2lnecNF9mJ4Xy4pgPj8