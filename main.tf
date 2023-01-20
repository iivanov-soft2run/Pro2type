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
  }
}

variable "do_token" {}

provider "digitalocean" {
  token = var.do_token
}

provider "helm" {
  kubernetes {
    host                   = resource.digitalocean_kubernetes_cluster.pro2type.endpoint
    client_certificate     = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_certificate)
    client_key             = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].client_key)
    cluster_ca_certificate = base64decode(resource.digitalocean_kubernetes_cluster.pro2type.kube_config[0].cluster_ca_certificate)
  }
}
data "digitalocean_project" "pro2type" {
  name = "pro2type"
}

resource "digitalocean_kubernetes_cluster" "pro2type" {
  name   = "pro2type"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.25.4-do.0"
  node_pool {
    name       = "pro2type-pool-1"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 3
    max_nodes  = 6
    node_count = 3
  }
}

resource "digitalocean_project_resources" "pro2type" {
  project = data.digitalocean_project.pro2type.id
  resources = [
    digitalocean_kubernetes_cluster.pro2type.urn
  ]
}

resource "helm_release" "example" {
  name       = "my-redis-release"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  version    = "17.5.1"
  namespace  = "test"
}