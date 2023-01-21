# Creates Kubernetes Cluster and Load Balancer in Digital Ocean

data "digitalocean_project" "pro2type" {
  name = "pro2type"
}

resource "digitalocean_kubernetes_cluster" "pro2type" {
  name    = "pro2type"
  region  = "fra1"
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