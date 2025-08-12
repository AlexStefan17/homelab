## Proxmox Terraform

## Configure Terraform Variables 
In the **/terraform** directory, create a file named **terraform.tfvars** to define your variable values.
```
ssh_key = "<ssh_key>"
cipassword = "<password>"
vm_network = "vmbr0"
vm_gateway = "172.20.50.1"

proxmox_api_url          = "https://<ip>>:8006/api2/json"
proxmox_api_token_id     = "<terraform_token>"
proxmox_api_token_secret = "<token>"

vm_list = {
  vm1 = {
    vm_name      = "k3s-master-terraform"
    vm_memory    = 2048
    vm_cores     = 2
    vm_disk_size = "32G"
    vm_ip        = "172.20.50.150"
  }

  vm2 = {
    vm_name      = "k3s-worker-terraform"
    vm_memory    = 1024
    vm_cores     = 1
    vm_disk_size = "32G"
    vm_ip        = "172.20.50.151"
  }
}
```

## Initialize and Apply
```
terraform init
terraform plan
terraform apply -auto-approve
```