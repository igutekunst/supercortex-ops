# 0002: Infrastructure as Code (Terraform)

**Date**: 2025-12-09
**Topics**: Terraform, DigitalOcean, Automation

## Decision
We have decided to use **Terraform** to provision the underlying compute resources. Manual creating of VMs is error-prone and non-reproducible.

## Provider Choice
We are creating the initial configuration for **DigitalOcean** as it provides a simple, high-performance API and good cost-to-performance ratio for this scale (3 nodes).

## Configuration
*   **Module**: Standard `digitalocean_droplet` Setup.
*   **Count**: 3 Nodes (`cortex-node-01` to `03`).
*   **SSH Keys**: Automatically managing SSH keys via Terraform.
*   **Output**: The config outputs `node_ips` which can be fed into the Ansible inventory manually or programmatically.

## Next Steps
Use the outputs from Terraform to populate `infrastructure/ansible/inventory/hosts.ini` and then run the bootstrap playbook.
