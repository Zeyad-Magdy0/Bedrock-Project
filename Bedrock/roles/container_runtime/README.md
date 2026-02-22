# container_runtime

Installs and configures containerd as the container runtime for Kubernetes nodes.

## Description

This role installs and configures `containerd` in a deterministic and production-aligned way for use with kubeadm-based Kubernetes clusters.

It ensures:

- containerd is installed
- Systemd cgroup driver is enabled
- Required kernel modules are loaded
- Required sysctl settings are applied
- containerd service is enabled and running

This role is designed to be idempotent and safe to re-run.

---

## Requirements

- Ubuntu 20.04+ / 22.04+
- Root privileges
- Internet access to download packages

---

## Role Variables

| Variable | Default | Description |
|----------|----------|-------------|
| `containerd_version` | latest | Version of containerd to install |

---

## Dependencies

None.

---

## Example Playbook

```yaml
- hosts: k8s_nodes
  roles:
    - container_runtime