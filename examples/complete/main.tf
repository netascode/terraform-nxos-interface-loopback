module "nxos_interface_loopback" {
  source  = "netascode/interface-loopback/nxos"
  version = ">= 0.1.1"

  id           = 10
  admin_state  = true
  vrf          = "VRF1"
  ipv4_address = "2.1.1.1/24"
  ipv4_secondary_addresses = [
    "2.1.2.1/24",
    "2.1.3.1/24"
  ]
  description = "Terraform was here"
}
