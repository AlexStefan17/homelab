## Proxmox Terraform

## Configure Terraform Variables 
Create ```terraform.tfvars``` file
```
proxmox_api_url          = "https://<proxmox-host>:8006/api2/json"
proxmox_api_token_id     = "<token_id>"
proxmox_api_token_secret = "<token_secret>"
vm_memory                = 2048
vm_cores                 = 2
vm_disk_size             = "32G"
vm_network               = "vmbr0"
vm_ip_base               = "172.20.50."
vm_ip_start              = 150
vm_gateway               = "172.20.50.1"
vm_count                 = 2
vm_name                  = "terraform-vm"
cipassword               = "vm_password"
```

## Initialize and Apply
```
terraform init
terraform plan
terraform apply -auto-approve
```