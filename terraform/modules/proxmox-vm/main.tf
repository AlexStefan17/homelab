terraform {
  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "3.0.2-rc05"
    }
  }
  required_version = ">= 1.2.0"
}


resource "proxmox_vm_qemu" "vm" {
  name        = var.vm_name
  target_node = "alexproxmox"
  clone       = "debian13-template"
  full_clone  = true
  cores       = var.vm_cores
  memory      = var.vm_memory
  scsihw      = "virtio-scsi-single"

  disk {
    slot    = "scsi0"
    size    = var.vm_disk_size
    type    = "disk"
    storage = "local-lvm"
  }

  disk {
    slot    = "ide2"
    type    = "cloudinit"
    storage = "local-lvm"
  }

  network {
    id     = 0
    model  = "virtio"
    bridge = var.vm_network
  }

  serial {
    id   = 0
    type = "socket"
  }

  os_type    = "cloud-init"
  ipconfig0  = "ip=${var.vm_ip}/24,gw=${var.vm_gateway}"
  sshkeys    = var.ssh_key
  ciuser     = var.ciuser
  cipassword = var.cipassword

  automatic_reboot = true

  lifecycle {
    ignore_changes = [network, sshkeys]
  }
}
