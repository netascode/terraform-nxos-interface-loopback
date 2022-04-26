locals {
  id = "lo${var.id}"
}

resource "nxos_loopback_interface" "l3LbRtdIf" {
  interface_id = local.id
  admin_state  = var.admin_state ? "up" : "down"
  description  = var.description
}

resource "nxos_loopback_interface_vrf" "nwRtVrfMbr" {
  interface_id = local.id
  vrf_dn       = "sys/inst-${var.vrf}"
  depends_on = [
    nxos_loopback_interface.l3LbRtdIf
  ]
}

resource "nxos_ipv4_interface" "ipv4If" {
  vrf          = var.vrf
  interface_id = local.id
  depends_on = [
    nxos_loopback_interface_vrf.nwRtVrfMbr
  ]
}

resource "nxos_ipv4_interface_address" "ipv4Addr" {
  count        = var.ipv4_address != null ? 1 : 0
  vrf          = var.vrf
  interface_id = local.id
  address      = var.ipv4_address
  depends_on = [
    nxos_ipv4_interface.ipv4If
  ]
}
