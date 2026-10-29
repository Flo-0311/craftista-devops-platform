
#Download Ubuntu Image
resource "proxmox_download_file" "ubuntu_cloud_image" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.virtual_environment_node_name

  url = "https://cloud-images.ubuntu.com/jammy/current/jammy-server-cloudimg-amd64.img"
}



#Create VM Template
resource "proxmox_virtual_environment_vm" "ubuntu_template" {
  name      = "ubuntu-template"
  node_name = var.virtual_environment_node_name

  template = true
  started  = false

  machine     = var.machine
  bios        = var.bios
  description = "Managed by Terraform"

  cpu {
    cores = var.cpu
  }

  memory {
    dedicated = var.memory
  }

  efi_disk {
    datastore_id = var.datastore_id
    type         = "4m"
  }

  disk {
    datastore_id = var.datastore_id
    file_id      = proxmox_download_file.ubuntu_cloud_image.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = var.disk_size
  }

  initialization {
    datastore_id = var.datastore_id
    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

  }

  network_device {
    bridge = "vmbr0"
  }

}



#Create 4 Clone VMs
resource "proxmox_virtual_environment_vm" "ubuntu_clone" {
  count = 4
  name      = "${var.vm_name}-${count.index}"
  node_name = var.virtual_environment_node_name
  started = true
 

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    # NOTE: The agent is installed and enabled as part of the cloud-init configuration in the template VM, see cloud-config.tf
    # The working agent is *required* to retrieve the VM IP addresses.
    # If you are using a different cloud-init configuration, or a different clone source
    # that does not have the qemu-guest-agent installed, you may need to disable the `agent` below and remove the `vm_ipv4_address` output.
    # See https://bpg.sh/docs/resources/virtual_environment_vm#qemu-guest-agent for more details.
    enabled = false
  }

  memory {
    dedicated = var.memory
  }

  initialization {
    datastore_id = var.datastore_id
    dns {
      servers = ["1.1.1.1"]
    }
    ip_config {
      ipv4 {
        # TEMPORARY REDACTION: restore the VM address range and gateway before use.
        address = "XX.XX.XX.XX/24"
        gateway = "XX.XX.XX.XX"
      }
    }
    user_account {
        # TEMPORARY REDACTION: restore the cloud-init username before use.
        username = "XX"
        keys = [
            trimspace(file("/root/.ssh/id_rsa.pub"))
        ]
    }
  }
}
