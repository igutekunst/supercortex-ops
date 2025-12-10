variable "do_token" {
  description = "DigitalOcean API Token"
  type        = string
  sensitive   = true
}

variable "ssh_key_path" {
  description = "Path to the public SSH key to embed"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "region" {
  description = "DigitalOcean Region"
  type        = string
  default     = "nyc3"
}

variable "droplet_size" {
  description = "Droplet Size"
  type        = string
  default     = "s-2vcpu-4gb" # Recommended for K3s nodes
}
