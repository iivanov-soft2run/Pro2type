# Pro2type
Chatops tool for quick environment provisioning

# Default Requirements:

Digital Ocean account
Terraform Cloud account
Digital Ocean access token set to DO_API_TOKEN repository secret
Terraform Cloud access token set to TF_API_TOKEN repository secret

# Installation:
By default the control plane will be installed on Digital Ocean. 
This could be changed by replacing the digital ocean resources and refferences in main.tf and cloud-infrastructure.tf with cloud provider of your choice. 

To install from github you can go to action and manually start the install workflow

This will create a Kubernetes cluster and load blanacer in Digital Ocean, then install ArgoCD and Crossplane on the cluster.

# Crossplane providers:
By default only the Digital Ocean Crossplane provider is added. 


# Inspiration
https://open.spotify.com/episode/50o2lnecNF9mJ4Xy4pgPj8