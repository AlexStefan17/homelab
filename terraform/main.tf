resource "proxmox_vm_qemu" "vm-instance" {
  count       = var.vm_count
  name        = "${var.vm_name}-${count.index + 1}"
  target_node = "alexproxmox"
  clone       = "debian12-template"
  full_clone          = true
  cores  = var.vm_cores
  memory = var.vm_memory
  scsihw = "virtio-scsi-single"

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

  os_type   = "cloud-init"
  # ipconfig0 = "ip=dhcp"
  ipconfig0 = "ip=${var.vm_ip_base}${count.index + var.vm_ip_start}/24,gw=${var.vm_gateway}"
  sshkeys   = var.ssh_key
  
  automatic_reboot = true

  lifecycle {
    ignore_changes = [network, sshkeys]
  }
}