module "vms" {
  for_each = var.vm_list
  source   = "./modules/proxmox-vm"

  vm_name      = each.value.vm_name
  vm_memory    = each.value.vm_memory
  vm_cores     = each.value.vm_cores
  vm_disk_size = each.value.vm_disk_size
  vm_ip        = each.value.vm_ip

  vm_network   = var.vm_network
  vm_gateway   = var.vm_gateway
  vm_vlan_tag  = lookup(each.value, "vm_vlan_tag", null)
  
  ssh_key      = var.ssh_key
  ciuser       = var.ciuser
  cipassword   = var.cipassword
}
