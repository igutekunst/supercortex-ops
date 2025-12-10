# 0001: Initial Design and Tech Stack Selection

**Date**: 2025-12-09
**Topics**: Principles, Architecture, Tech Stack

## Key Design Decisions

1.  **Principles First**: The system is grounded in the "Constitutional" authority of The Principle (User). Security is paramount ("Do No Harm").
2.  **Fractal Architecture**: The system uses recursive compartmentalization. "Structure enables Flow."
3.  **Bootstrapping**: We will use a "Community of Experts" topology and bootstrap from a core K3s cluster.

## Technology Stack (The "SuperCortex" Stack)

We analyzed "Tried & True" vs "Cool & Hip" and settled on a high-performance, modern stack:

*   **Fabric**: **Netmaker** (Kernel WireGuard Mesh) for flat networking across disparate nodes.
*   **CNI/Mesh**: **Cilium** (eBPF) for strict mTLS, identity-aware policies, and observance.
*   **Storage**: **Longhorn** (Tried & true block storage).
*   **Auth**: **Authentik** (Modern, flexible SSO).
*   **Secrets**: **Vault** (The industry standard for rigorous security).
*   **Observability**: **SigNoz** (OpenTelemetry native).
*   **GitOps**: **ArgoCD** + **Gitea** + **Woodpecker CI**.

## Deployment Strategy
We agreed on a 6-phase deployment plan starting with base OS hardening, then Netmaker mesh, then K3s+Cilium, followed by the GitOps bootstrap.
