
---

`validations/README.md`

```markdown
# validations

Performs passive cluster validation checks.

## Description

This role validates Kubernetes cluster health without modifying system state.

Checks include:

- API server availability
- Node readiness
- Control plane status
- Workload readiness
- Vault readiness (optional)

This role does not attempt recovery or modification.

It is purely observational.

---

## Requirements

- Working kubeconfig
- Kubernetes cluster initialized

---

## Example Playbook

```yaml
- hosts: control_plane
  roles:
    - validations