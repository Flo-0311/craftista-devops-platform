terraform {
    required_providers {
        proxmox = {
            source = "bpg/proxmox"
            version = "~>0.111"
        }
    }
}

provider "proxmox" {
    #user and pass set as env var
    # TEMPORARY REDACTION: restore the Proxmox API endpoint before use.
    endpoint = "https://XX.XX.XX.XX:8006/"
    insecure = true
    ssh {
        agent = true
        # TEMPORARY REDACTION: restore the SSH username before use.
        username = "XX"
    }
}