locals {
  vm_system_drive_default = "${local.hyperv_host.data_drive}:\\${local.hyperv_host.data_dir}\\${var.vm_name}\\Disks\\${var.vm_name}.vhdx"
}

resource "hyperv_vhd" "vm_vhd" {
  path     = local.vm_system_drive_default
  vhd_type = "Dynamic"
  size     = "64424509440" # 60GB
}


resource "hyperv_machine_instance" "vm" {
  name                   = var.vm_name
  notes                  = var.vm_description
  generation             = 1
  state                  = "Running"
  static_memory          = true
  memory_startup_bytes   = "8589934592" # 8Gb
  processor_count        = 1
  smart_paging_file_path = "${local.hyperv_host.data_drive}:\\${local.hyperv_host.data_dir}\\${var.vm_name}"
  snapshot_file_location = "${local.hyperv_host.data_drive}:\\${local.hyperv_host.data_dir}\\${var.vm_name}"
  automatic_stop_action  = "Save"
  checkpoint_type        = "Production"
  automatic_start_action = "StartIfRunning"
  integration_services = {
    "Guest Service Interface" = false
    "Heartbeat"               = true
    "Key-Value Pair Exchange" = true
    "Shutdown"                = true
    "Time Synchronization"    = true
    "VSS"                     = true
  }
  network_adaptors {
    name        = "wan"
    switch_name = var.switch
  }
  hard_disk_drives {
    controller_type     = "Ide"
    controller_number   = "0"
    controller_location = "0"
    path                = local.vm_system_drive_default
  }
  dvd_drives {
    controller_number   = "0"
    controller_location = "1"
    path                = var.vm_iso
  }
}
