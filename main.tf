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
      version = "~> 2.0"
    }
  }
}
variable "do_token" {}
provider "digitalocean" {
  token = var.do_token
}
#An example resource that does nothing.
resource "digitalocean_kubernetes_cluster" "pro2type" {
  name   = "pro2type"
  region = "fra1"
  # Grab the latest version slug from `doctl kubernetes options versions`
  version = "1.25.4-do.0"

  node_pool {
    name       = "pro2type-pool-1"
    size       = "s-1vcpu-2gb"
    node_count = 3
  }
}