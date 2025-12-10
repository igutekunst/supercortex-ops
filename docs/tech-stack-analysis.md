# Tech Stack Analysis & Decisions

## 1. Network Fabric (WireGuard Mesh)
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **Tailscale / Headscale** | User-friendly | Extremely easy, strict identity, ACLs. | Tailscale is SaaS (Headscale is self-hosted but strictly purely OSS). | **Headscale** (if self-hosted strictness is key) or **Netmaker**. |
| **Netmaker** | Performance | Kernel WireGuard (fast), auto-mesh, K8s focused. | Newer than Tailscale. | **Strong Contender** for "Cool & Hip" + Speed. |
| **Cilium Mesh** | Integrated | Integrated with CNI. | Complex setup for external VMs. | Good if using Cilium CNI. |

## 2. Service Mesh & CNI
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **Cilium** | eBPF CNI/Mesh | High performance (eBPF), strict security, hubble observability. | Steep learning curve, but standard for "Modern". | **High** (Combines CNI + Mesh + Security). |
| **Istio** | Sidecar | The industry standard, feature-rich. | Resource heavy, complexity "sprawl". | Maybe too heavy for 3 nodes? |
| **Linkerd** | Sidecar (Rust) | Lightweight, incredibly fast, "just works". | Less "platform" features than Istio/Cilium. | **Solid** for resource efficiency. |

## 3. Storage
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **Longhorn** | Block (Rancher) | Easy backup (S3), GUI, sturdy. | Performance can be mediocre. | **Tried & True** (User suggested). |
| **Rook (Ceph)** | Block/Obj/File | The "Enterprise" standard. | Very complex, resource hungry. | Overkill? |
| **OpenEBS (Mayastor)** | NVMe/Rust | High performance. | Newer. | if usage is high IO. |

## 4. Identity & Auth (SSO)
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **Keycloak** | Java | The standard, does EVERYTHING. | Heavy (Java), complex to theme. | **Tried & True**. |
| **Authentik** | Python/Go | Modern, great UI, easy flows, lighter. | Newer. | **Cool & Hip** + Functional. |
| **Authelia** | Go | Very lightweight, simple. | Less standard OIDC features than above (improving). | Good for simple setups. |

## 5. Secrets & Keys
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **HashiCorp Vault** | The Standard | Does everything (PKI, Transit, KV). | Complex Ops. | **The Standard** (User suggested). |
| **Infisical** | Modern | "Vault for Humans", focused on Dev Exp. | Newer. | **Cool & Hip**. |

## 6. Observability
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **SigNoz** | All-in-one | OpenTelemetry native, ClickHouse backed (fast queries). | Newer. | **Cool & Hip** (User suggested). |
| **Prometheus/Grafana/Tempo**| Modular | The absolute standard. | Integration effort required. | **Tried & True**. |
| **Cilium Hubble** | Network Vis | deep network insights. | Not a full app trace solution (needs Tempo/Jaeger). | Use as *addon* to above. |

## 7. GitOps / CI / Registry
| Option | Type | Pros | Cons | Recommendation |
| :--- | :--- | :--- | :--- | :--- |
| **GitLab (Self-Hosted)** | All-in-one | Git, CI, Registry in one box. | VERY resource heavy. | Maybe too heavy. |
| **Gitea + Woodpecker CI**| Modular | Extremely lightweight, fast. | Integration manual. | **Cool & Efficient**. |
| **ArgyCD / Flux** | CD | The K8s way to deploy. | | **Essential** for GitOps. |
| **Harbor** | Registry | Enterprise standard registry (scanning etc). | Heavy. | **Tried & True**. |

## Final "SuperCortex" Stack Decision
*   **Fabric**: [Netmaker](https://www.netmaker.io/) (Kernel WireGuard Mesh)
*   **CNI/Mesh**: [Cilium](https://cilium.io/) (eBPF mode, strict policies, mTLS)
*   **Storage**: [Longhorn](https://longhorn.io/)
*   **Auth**: [Authentik](https://goauthentik.io/)
*   **Secrets**: [HashiCorp Vault](https://www.vaultproject.io/)
*   **Observability**: [SigNoz](https://signoz.io/)
*   **GitOps/CI**: Gitea + Woodpecker + ArgoCD
*   **Registry**: Harbor (or Gitea Package Registry if sufficient) -> *Decision: Harbor for full feature set.*
