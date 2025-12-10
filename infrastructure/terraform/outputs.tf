output "node_ips" {
  value = {
    for node in digitalocean_droplet.cortex_node :
    node.name => node.ipv4_address
  }
}
