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

resource "nxos_vrf" "vrf" {
  name = "VRF1"
}

module "main" {
  source = "../.."

  id           = 10
  admin_state  = true
  vrf          = "VRF1"
  ipv4_address = "2.1.1.1/24"
  ipv4_secondary_addresses = [
    "2.1.2.1/24",
    "2.1.3.1/24"
  ]
  description = "Terraform was here"

  depends_on = [nxos_vrf.vrf]
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

  equal "description" {
    description = "description"
    got         = data.nxos_loopback_interface.l3LbRtdIf.description
    want        = "Terraform was here"
  }
}

data "nxos_loopback_interface_vrf" "nwRtVrfMbr" {
  interface_id = "lo10"

  depends_on = [module.main]
}

resource "test_assertions" "nwRtVrfMbr" {
  component = "nwRtVrfMbr"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_loopback_interface_vrf.nwRtVrfMbr.interface_id
    want        = "lo10"
  }

  equal "vrf_dn" {
    description = "vrf_dn"
    got         = data.nxos_loopback_interface_vrf.nwRtVrfMbr.vrf_dn
    want        = "sys/inst-VRF1"
  }
}

data "nxos_ipv4_interface" "ipv4If" {
  interface_id = "lo10"
  vrf          = "VRF1"

  depends_on = [module.main]
}

resource "test_assertions" "ipv4If" {
  component = "ipv4If"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_ipv4_interface.ipv4If.interface_id
    want        = "lo10"
  }

  equal "vrf" {
    description = "vrf"
    got         = data.nxos_ipv4_interface.ipv4If.vrf
    want        = "VRF1"
  }
}

data "nxos_ipv4_interface_address" "ipv4Addr" {
  interface_id = "lo10"
  vrf          = "VRF1"
  address      = "2.1.1.1/24"

  depends_on = [module.main]
}

resource "test_assertions" "ipv4Addr" {
  component = "ipv4Addr"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_ipv4_interface_address.ipv4Addr.interface_id
    want        = "lo10"
  }

  equal "vrf" {
    description = "vrf"
    got         = data.nxos_ipv4_interface_address.ipv4Addr.vrf
    want        = "VRF1"
  }

  equal "address" {
    description = "address"
    got         = data.nxos_ipv4_interface_address.ipv4Addr.address
    want        = "2.1.1.1/24"
  }
}

data "nxos_ipv4_interface_address" "secondary_ipv4Addr_1" {
  interface_id = "lo10"
  vrf          = "VRF1"
  address      = "2.1.2.1/24"

  depends_on = [module.main]
}

resource "test_assertions" "secondary_ipv4Addr_1" {
  component = "secondary_ipv4Addr_1"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_1.interface_id
    want        = "lo10"
  }

  equal "vrf" {
    description = "vrf"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_1.vrf
    want        = "VRF1"
  }

  equal "address" {
    description = "address"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_1.address
    want        = "2.1.2.1/24"
  }
}

data "nxos_ipv4_interface_address" "secondary_ipv4Addr_2" {
  interface_id = "lo10"
  vrf          = "VRF1"
  address      = "2.1.3.1/24"

  depends_on = [module.main]
}

resource "test_assertions" "secondary_ipv4Addr_2" {
  component = "secondary_ipv4Addr_2"

  equal "interface_id" {
    description = "interface_id"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_2.interface_id
    want        = "lo10"
  }

  equal "vrf" {
    description = "vrf"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_2.vrf
    want        = "VRF1"
  }

  equal "address" {
    description = "address"
    got         = data.nxos_ipv4_interface_address.secondary_ipv4Addr_2.address
    want        = "2.1.3.1/24"
  }
}
