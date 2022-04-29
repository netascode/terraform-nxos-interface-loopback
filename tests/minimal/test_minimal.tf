terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    nxos = {
      source  = "netascode/nxos"
      version = ">=0.3.7"
    }
  }
}

module "main" {
  source = "../.."

  id = 10
}

data "nxos_loopback_interface" "l3LbRtdIf" {
  interface_id = "lo10"

  depends_on = [module.main]
}

resource "test_assertions" "l3LbRtdIf" {
  component = "l3LbRtdIf"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_loopback_interface.l3LbRtdIf.interface_id
    want        = "lo10"
  }

  equal "admin_state" {
    description = "admin_state"
    got         = data.nxos_loopback_interface.l3LbRtdIf.admin_state
    want        = "up"
  }
}
