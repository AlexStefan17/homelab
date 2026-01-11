# Ansible scripts for k3s VMs

## Install ansible

## Install kubernetes collection
```
ansible-galaxy collection install community.general
ansible-galaxy collection install kubernetes.core
ansible-galaxy collection install kubernetes.core
```

## From root directory run:
# Prod Env
```
ansible-playbook -i ./inventory/inventory.yaml ./playbooks/site.yaml --ask-vault-pass
```
# Test Env
```
ansible-playbook -i ./inventory/inventory-test.yaml ./playbooks/site-test.yaml --ask-vault-pass
```