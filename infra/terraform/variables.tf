variable "virtual_environment_node_name" {
    type = string
    default = "sept25-continu-en-florian-sockshop"
}

variable "vm_name" {
    type = string
    default = "cluster-node"
}

variable "datastore_id" {
    type = string
    default = "vmdata" 
}

variable "machine" {
    type = string
    default = "q35"
}

variable "bios" {
    type = string
    default = "ovmf"
}

variable "cpu" {
    type = number
    default = 2
}

variable "memory" {
    type = number
    default = 8192
}

variable "disk_size" {
    type = number
    default = 20
}

