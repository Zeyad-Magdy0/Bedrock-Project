
---

`kubernetes/README.md`

```markdown
# kubernetes

Bootstraps and manages a kubeadm-based Kubernetes control plane and worker nodes.

## Description

This role initializes and manages a Kubernetes cluster using kubeadm with explicit state detection and controlled recovery logic.

It implements:

- Deterministic control-plane initialization
- API health detection
- etcd health verification
- Controlled kubelet recovery
- Explicit rebuild mode (force_rebuild=true)
- Safe idempotent re-runs

The design avoids destructive behavior unless explicitly requested.

---

## Features

- Clean separation of cluster states
- No implicit resets
- Explicit rebuild guard
- Health-driven logic
- Designed for production experimentation

---

## Requirements

- containerd installed
- Swap disabled
- Required kernel modules loaded

---

## Role Variables

| Variable | Description |
|----------|-------------|
| `pod_network_cidr` | Pod network CIDR |
| `init_k8s_version` | Kubernetes version for kubeadm init |
| `force_rebuild` | Explicit full cluster rebuild (default: false) |

---

## Example Playbook

```yaml
- hosts: control_plane
  roles:
    - kubernetes