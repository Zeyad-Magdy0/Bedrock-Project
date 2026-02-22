
---

 `linux_baseline/README.md`

```markdown
# linux_baseline

Applies baseline system configuration required for Kubernetes nodes.

## Description

This role prepares Ubuntu hosts for Kubernetes installation.

It configures:

- Kernel modules (br_netfilter, overlay)
- sysctl networking settings
- Swap disabling
- Required OS packages
- Time synchronization validation

This role ensures nodes meet Kubernetes prerequisites before runtime or kubeadm execution.

---

## Requirements

- Ubuntu 20.04+
- Root privileges

---

## Example Playbook

```yaml
- hosts: all
  roles:
    - linux_baseline