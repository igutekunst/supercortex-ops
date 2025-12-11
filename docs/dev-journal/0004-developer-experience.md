# 0004: Developer Experience (DevContainer)

**Date**: 2025-12-09
**Topics**: DevContainer, VS Code, Environment Consistency

## Decision
To ensure that all engineers (and the Agent) run infrastructure commands (`terraform`, `ansible`, `kubectl`) in a consistent environment, we introduced a **DevContainer**.

## Configuration
*   **Base Image**: Uses our custom `infrastructure/deployer/Dockerfile` (Ubuntu 22.04 + Tools).
*   **Mounts**: Binds local SSH keys (`~/.ssh`) to the container so that Git and Ansible can authenticat.
*   **Extensions**: Pre-installs Terraform, Ansible, and K8s extensions for VS Code.

## Workflow
1.  Open Project in VS Code.
2.  "Reopen in Container".
3.  Run `terraform init`, `ansible-playbook`, etc. directly from the integrated terminal.
