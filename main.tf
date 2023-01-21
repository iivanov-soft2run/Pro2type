# Define and configure Providers needed for installing Pro2type
terraform {
  cloud {
    organization = "Pro2type"
    workspaces {
      name = "Pro2type-Telerik"
    }
  }
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.25.2"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.8.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.16.1"
    }
  }
}

# Digital Ocean
variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

# Helm with Digital Ocean Cluster Credentials
provider "helm" {
  kubernetes {
    host                   = resource.digitalocean_kubernetes_cluster.pro2type.endpoint
    client_certificate     = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_certificate)
    client_key             = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].cluster_ca_certificate)
    token                  = resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].token
  }
}

# Kubernetes with Digital Ocean Cluster Credentials
provider "kubernetes" {
  host                   = resource.digitalocean_kubernetes_cluster.pro2type.endpoint
  client_certificate     = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_certificate)
  client_key             = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_key)
  cluster_ca_certificate = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].cluster_ca_certificate)
  token                  = resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].token
}