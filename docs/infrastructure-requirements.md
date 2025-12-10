# Infrastructure Requirements

## Core Infrastructure
- **Compute**: 3 VMs (potentially disparate hosts).
- **Network Fabric**: "Fully connected WireGuard mesh" between nodes.
- **Orchestrator**: K3s.

## Security (Rigorous)
- **Transport Security**: mTLS between services.
- **Ingress**: Proper SSL with automatic Let's Encrypt.
- **Identity & Access**: 
    - Auth service for web app SSO.
    - Ephemeral keys for services (Vault or similar).
- **Secrets Management**: HashiCorp Vault or similar/better.

## Storage & Data
- **Storage Solution**: Distributed block storage (e.g., Longhorn).

## Observability & Operations
- **Tracing**: Distributed tracing.
- **Metrics/Logs**: SigNoz, Grafana, or equivalent.
- **Service Mesh**: Essential for mTLS and traffic control.

## DevOps / GitOps
- **CI/CD**: Continuous Integration/Deployment system.
- **Source Control**: Git server.
- **Artifacts**: Container registry.
