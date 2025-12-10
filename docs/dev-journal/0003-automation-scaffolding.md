# 0003: Automation Scaffolding (Ansible & Netmaker)

**Date**: 2025-12-09
**Topics**: Ansible, Netmaker, Scaffolding

## Decision
To ensure consistent configuration across the nodes, we are using **Ansible**.
We have scaffolded the initial playbook structure to:
1.  Prepare the OS (dependencies).
2.  Install K3s (Master/Worker logic).
3.  Install **Netmaker** (VPN Fabric).

## Netmaker Integration
We decided to install the Netmaker *Server* on the first node (`cortex-node-01`) via a dedicated playbook (`install_netmaker.yml`).
This will serve as the mesh coordinator. The other nodes (and the server itself) will join this mesh network using `netclient`.

## Directory Structure
*   `infrastructure/terraform`: Provisioning (DO).
*   `infrastructure/ansible`: Configuration Management (OS, K3s, Netmaker).
*   `infrastructure/k8s`: Workload manifests (GitOps target).
