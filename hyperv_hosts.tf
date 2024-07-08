variable "vm_name" {
  type = string
}

variable "vm_description" {
  type = string
}

variable "vm_iso" {
  type = string
}

variable "switch" {
  type = string
}

variable "default_admin_user" {
  type = string
}

variable "default_password" {
  type = string
}

variable "hyperv_hosts" {
  type = map(object({
    server     = string
    data_drive = string
    data_dir   = string
  }))
  default = {
    "vmhost1" = {
      server     = "192.168.169.111"
      data_drive = "H"
      data_dir   = "vm"
    },
    "vmhost2" = {
      server     = "192.168.8.111"
      data_drive = "E"
      data_dir   = "vm"
    },
    "vmhost3" = {
      server     = "192.168.111.111"
      data_drive = "D"
      data_dir   = "vm"
    },
    "vmhost4" = {
      server     = "192.168.254.204"
      data_drive = "D"
      data_dir   = "vm"
    },
    "vmhost5" = {
      server     = "192.168.10.50"
      data_drive = "G"
      data_dir   = "VM"
    }
  }
}

variable "selected_host" {
  type = string
}
