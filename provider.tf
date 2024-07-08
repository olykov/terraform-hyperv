
terraform {
  required_providers {
    hyperv = {
      source  = "taliesins/hyperv"
      version = "1.1.0"
    }
  }
}

locals {
  hyperv_host = merge(
    { admin_user = var.default_admin_user, password = var.default_password },
    var.hyperv_hosts[var.selected_host]
  )
}

provider "hyperv" {
  user        = local.hyperv_host.admin_user
  password    = local.hyperv_host.password
  host        = local.hyperv_host.server
  port        = 5986
  https       = true
  insecure    = true
  use_ntlm    = true
  script_path = "C:/Temp/terraform_%RAND%.cmd"
  timeout     = "30s"
}
