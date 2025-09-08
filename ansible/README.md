# Ansible scripts for k3s VMs

## Install ansible

## Install kubernetes collection
```
ansible-galaxy collection install community.general
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install kubernetes.core
```

## From root directory run:
```
ansible-playbook  playbooks/site.yaml --ask-vault-pass
```