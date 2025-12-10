terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_ssh_key" "default" {
  name       = "supercortex-key"
  public_key = file(var.ssh_key_path)
}

resource "digitalocean_droplet" "cortex_node" {
  count  = 3
  image  = "ubuntu-22-04-x64"
  name   = "cortex-node-${count.index + 1}"
  region = var.region
  size   = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.default.fingerprint]
  tags   = ["k3s", "supercortex"]
}

resource "digitalocean_project" "supercortex" {
  name        = "SuperCortex"
  description = "Agentic Environment Cluster"
  purpose     = "Web Application"
  environment = "Production"
  resources   = digitalocean_droplet.cortex_node[*].urn
}
