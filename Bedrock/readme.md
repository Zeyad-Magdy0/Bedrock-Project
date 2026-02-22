# Bedrock Platform – Automated Kubernetes + Vault Deployment

## Overview

Bedrock is an infrastructure automation project that provisions and configures a production-style Kubernetes cluster and deploys HashiCorp Vault using Ansible.

The project is structured in three execution phases plus a dedicated validation stage.

It demonstrates platform engineering principles including:
- Idempotent infrastructure automation
- Deterministic cluster bootstrap
- Explicit rebuild logic
- Passive validation design
- Separation of responsibilities between control-plane and workers

---

# Architecture

- Kubernetes cluster bootstrapped via kubeadm
- Container runtime: containerd
- CNI: Calico
- Vault deployed via Helm
- Ansible roles with clear responsibility boundaries
- Dynamic inventory support
- Explicit rebuild mode for control plane

---

# Project Structure


playbooks/
phase1_bootstrap.yml
phase2_kubernetes.yml
phase3_vault.yml
validate.yml

roles/
linux_baseline/
containerd/
kubernetes/
networking/
vault/

inventories/
dev/
hosts.ini
group_vars/


---

# Phase 1 – Node Bootstrap

Purpose: Prepare all nodes for Kubernetes.

Includes:
- OS validation (Ubuntu 22.04)
- Kernel module configuration
- Sysctl settings
- containerd installation and configuration
- kubeadm, kubelet, kubectl installation
- Swap disabled
- Preflight validation

Goal:
All nodes are Kubernetes-ready but not yet part of a cluster.

---

# Phase 2 – Kubernetes Cluster Deployment

Purpose: Initialize control plane and join workers.

Control Plane:
- kubeadm init
- Static pod creation
- API health checks
- Deterministic state detection
- Explicit rebuild mode (force_rebuild=true)
- Safe etcd wipe during rebuild

Workers:
- Token-based join
- Idempotent join detection
- No forced rejoin if already configured

Networking:
- Calico installation
- CNI rollout validation
- API readiness verification before CNI deployment

Design Principles:
- No blind resets
- No automatic destructive behavior
- Explicit operator-driven rebuild
- Separation between initialization and validation

---

# Phase 3 – Vault Deployment

Purpose: Deploy and expose HashiCorp Vault.

Includes:
- Helm repository configuration
- Helm upgrade --install
- Namespace creation
- Vault readiness checks
- Optional NodePort exposure
- Idempotent service creation

Vault is deployed only after:
- Kubernetes API is healthy
- Nodes are Ready
- Networking is operational

---

# Validation Playbook

Purpose: Passive cluster verification.

Design:
- Runs only on control plane
- No mutation
- No healing
- No destructive logic
- Deterministic checks

Validation includes:
- Wait for all nodes to report Ready
- Display node status
- Ensure Vault pods are Ready
- Display final cluster state

Example validation logic:

- Ensure no node contains "NotReady"
- Ensure Vault pods pass readiness condition
- Fail loudly if cluster is unstable

This phase is safe to re-run at any time.

---

# Rebuild Mode

The control plane supports an explicit rebuild mode:


ansible-playbook phase2_kubernetes.yml -e force_rebuild=true


Behavior:
- Stops kubelet
- kubeadm reset
- Wipes:
  - /etc/kubernetes
  - /var/lib/etcd
  - /var/lib/kubelet
  - CNI state
- Reinitializes cluster cleanly

Rebuild is:
- Explicit
- Operator-driven
- Never automatic

---

# Key Engineering Decisions

- No `kubectl wait --all` race conditions
- No validation from worker nodes
- No implicit destructive recovery
- Clear separation between init, join, networking, and validation
- Deterministic readiness checks
- Idempotent design throughout roles

---

# What This Project Demonstrates

- Infrastructure as Code discipline
- Platform-level thinking
- Failure scenario handling (etcd corruption, API instability)
- Idempotency engineering
- Production-style bootstrap sequencing
- Kubernetes operational understanding
- Ansible architecture design

---

# Future Improvements

- HA control plane (stacked etcd or external etcd)
- Automated etcd snapshotting
- Dynamic inventory with Terraform tagging
- CNI abstraction (Calico / Cilium switch)
- CI pipeline integration
- GitOps integration layer
- Observability stack (Prometheus + Grafana)

---

# Conclusion

Bedrock is a foundational platform automation project that models real-world Kubernetes cluster provisioning and secret management deployment using deterministic, production-oriented patterns.