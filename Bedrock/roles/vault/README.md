
---

 `vault/README.md`

```markdown
# vault

Deploys and validates HashiCorp Vault on Kubernetes.

## Description

This role installs and validates a Vault deployment inside Kubernetes.

It supports:

- Helm-based deployment
- Namespace creation
- Readiness validation
- Controlled initialization workflows

Designed for Kubernetes-native Vault usage.

---

## Requirements

- Kubernetes cluster operational
- kubectl configured
- Helm installed

---

## Role Variables

| Variable | Description |
|----------|-------------|
| `vault_namespace` | Namespace for Vault deployment |
| `vault_release_name` | Helm release name |
| `kubeconfig_path` | Path to kubeconfig |

---

## Example Playbook

```yaml
- hosts: control_plane
  roles:
    - vault