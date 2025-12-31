variable "ssh_key" {
  type = string
}

variable "ciuser" {
  type = string
  default = "alex"
}

variable "cipassword" {
  type = string
}

variable "vm_network" {
  type    = string
  default = "vmbr0"
}

variable "vm_gateway" {
  type    = string
  default = "172.20.50.1"
}

variable "vm_list" {
  type = map(object({
    vm_name      = string
    vm_memory    = number
    vm_cores     = number
    vm_disk_size = string
    vm_ip        = string
    vm_vlan_tag  = optional(number)
  }))
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type = string
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

variable "vm_vlan_tag" {
  type    = number
  default = null
}