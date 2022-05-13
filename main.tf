locals {
  id = "lo${var.id}"
}

resource "nxos_loopback_interface" "l3LbRtdIf" {
  device       = var.device
  interface_id = local.id
  admin_state  = var.admin_state ? "up" : "down"
  description  = var.description
}

resource "nxos_loopback_interface_vrf" "nwRtVrfMbr" {
  device       = var.device
  interface_id = local.id
  vrf_dn       = "sys/inst-${var.vrf}"
  depends_on = [
    nxos_loopback_interface.l3LbRtdIf
  ]
}

resource "nxos_ipv4_interface" "ipv4If" {
  device       = var.device
  vrf          = var.vrf
  interface_id = local.id
  depends_on = [
    nxos_loopback_interface_vrf.nwRtVrfMbr
  ]
}

resource "nxos_ipv4_interface_address" "ipv4Addr" {
  count        = var.ipv4_address != null ? 1 : 0
  device       = var.device
  vrf          = var.vrf
  interface_id = local.id
  address      = var.ipv4_address
  type         = "primary"
  depends_on = [
    nxos_ipv4_interface.ipv4If
  ]
}

resource "nxos_ipv4_interface_address" "secondary_ipv4Addr" {
  for_each     = toset(var.ipv4_secondary_addresses)
  device       = var.device
  vrf          = var.vrf
  interface_id = local.id
  address      = each.value
  type         = "secondary"
  depends_on = [
    nxos_ipv4_interface_address.ipv4Addr
  ]
}
