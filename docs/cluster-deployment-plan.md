# Cluster Deployment Plan

## Phase 1: Base Infrastructure (The 3 Nodes)
**Goal**: Prepare 3 Linux nodes with basic connectivity and OS hardening.
*   **OS**: Ubuntu 22.04 LTS or Debian 12 (Stable base).
*   **Dependencies**: `curl`, `wireguard-tools`, `software-properties-common`.
*   **Hostnames**: `cortex-node-01`, `cortex-node-02`, `cortex-node-03`.

## Phase 2: The Network Fabric (Netmaker)
**Goal**: Create a secure, flat, fully-connected mesh network covering all disparate nodes.
1.  **Netmaker Management Server**: Deploy on a "Hub" (or one of the nodes, though dedicated is better. *Recommendation: Use a small separate VPS or designate Node-01 as Master*).
2.  **Netclient**: Install on all 3 nodes.
3.  **Mesh Creation**: Create `cortex-mesh` network.
4.  **Verification**: Ensure all nodes can ping each other via private Mesh IP.

## Phase 3: The Orchestrator (K3s + Cilium)
**Goal**: Install K3s *without* default CNI (Flannel) and *without* Traefik (we might want Cilium Ingress or separate).
*   **K3s Init**: Initialize master with `--flannel-backend=none --disable-network-policy`.
*   **Cilium Install**: Install via Helm.
    *   Enable: `hubble`, `relay`, `ui`.
    *   Mode: `kube-proxy-replacement=strict`.
    *   Encryption: Enable WireGuard (on top of Netmaker? Or rely on Netmaker? *Recommendation: Rely on Netmaker for transport security between nodes to save overhead, use Cilium for mTLS between pods.*)

## Phase 4: Core GitOps & Secrets (The Bootstrap)
**Goal**: Get the cluster to manage itself.
1.  **ArgoCD**: Install manually (Helm) to bootstrapping the GitOps flow.
2.  **Vault**: Install via Helm. Initialize and unseal.
    *   Configure Kubernetes Auth Method.
    *   *Task*: Create a script to auto-inject secrets.

## Phase 5: Core Services (The Stack)
**Goal**: Deploy the agreed stack via ArgoCD.
*   **Repository Structure**:
    *   `/infrastructure/k8s/base` (ArgoCD, Sealed Secrets/Vault Agent)
    *   `/infrastructure/k8s/observability` (SigNoz)
    *   `/infrastructure/k8s/storage` (Longhorn)
    *   `/infrastructure/k8s/auth` (Authentik)
    *   `/infrastructure/k8s/apps` (User workloads)

## Phase 6: Operational Verification
*   Verify Longhorn replication across the mesh.
*   Verify SigNoz receiving traces.
*   Verify Authentik protecting a sample app.
