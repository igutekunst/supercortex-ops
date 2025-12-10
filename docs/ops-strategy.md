# Operational Strategy & GitOps Decisions

**Status**: Decided
**Date**: 2025-12-09

## 1. Infrastructure Layer (Metal / VM)
**Decision**: **Semi-Automated (Manual Trigger)** via Terraform.
*   **Workflow**: Engineer runs `terraform plan` -> reviews output -> runs `terraform apply` locally.
*   **State Management**: Remote state (S3/DigitalOcean Spaces) to ensure safety and sharing.
*   **Rationale**: 
    *   Changes are low-frequency but high-risk (e.g., destroying a node).
    *   Manual review prevents catastrophic "fat-finger" errors that could wipe the cluster.
*   **Rejected Alternatives**:
    *   *CI-Driven Infrastructure*: Rejected because the complexity of setting up secure runners and locking mechanisms is unnecessary for the current team size.

## 2. Configuration Layer (OS / Node)
**Decision**: **Bootstrap Only** via Ansible.
*   **Workflow**: Run Playbook ONCE after Terraform to "pave" the node (install K3s, Netmaker, Docker).
*   **Rationale**: 
    *   K8s nodes should remain relatively immutable.
    *   Avoids the complexity of keeping Ansible idempotent over long periods of drift.
*   **Rejected Alternatives**:
    *   *Continuous Configuration (Cron/Tower)*: Rejected. If a node drifts significantly, we prefer to replace it (Immutable Infrastructure pattern) rather than drag it back into compliance.

## 3. Application Layer (Core Services & Workloads)
**Decision**: **GitOps** via ArgoCD.
*   **Workflow**:
    1.  Commit manifest/chart change to `infrastructure/k8s/`.
    2.  ArgoCD (running in cluster) detects change.
    3.  ArgoCD syncs cluster state to match git.
*   **Rationale**:
    *   Provides a perfect audit trail of *what* is running (History = Git Log).
    *   Auto-healing: If an admin deletes a deployment by mistake, ArgoCD restores it.
    *   Eliminates "Configuration Drift" completely.
*   **Rejected Alternatives**:
    *   *Manual `kubectl apply`*: Rejected. Leads to undocumented state and "snowflake" clusters.
    *   *CI Push (Jenkins/Actions pushing to K8s)*: Rejected. Requires giving CI admin keys to the cluster (security risk). GitOps "Pull" model is more secure.

---

## 4. GitOps Directory Structure Design

### The "Seed" (`infrastructure/k8s/base`)
This directory contains the **minimum viable manifests** to bootstrap the GitOps engine.
*   **Contents**:
    *   ArgoCD Install Manifests (Kustomize upstream).
    *   Sealed Secrets Controller (encryption bootstrap).
    *   The "App of Apps" (Root Application).
*   **Usage**: Applied ONCE manually (`kubectl apply -k infrastructure/k8s/base`) to bootstrapping.

### The "Payload" (`infrastructure/k8s/apps`, `observability`, etc.)
Managed purely by ArgoCD.
*   **Contents**: Authentik, SigNoz, Longhorn, User Apps.
