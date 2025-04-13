terraform {
    required_providers {
        proxmox = {
            source = "telmate/proxmox"
        }
    }
}

provider "proxmox" {
    pm_api_url   = "/api2/json"
    pm_user = ""
    pm_api_token_id = ""
    pm_api_token_secret = ""
    pm_tls_insecure = true
}


resource "proxmox_vm_qemu" "vm-instance" {
    name                = "terraform-vm"
    target_node         = "alexproxmox"
    clone               = "debian12-ansible-template"
    full_clone          = true
    cores               = 2
    memory              = 2048
    onboot = true

    disk {
        size            = "32G"
        type            = "scsi"
        storage         = "local-lvm"
        discard         = "on"
    }

    network {
        model     = "virtio"
        bridge    = "vmbr0"
        firewall  = false
        link_down = false
    }

}