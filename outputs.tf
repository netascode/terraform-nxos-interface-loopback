output "dn" {
  value       = nxos_loopback_interface.l3LbRtdIf.id
  description = "Distinguished name of the object."
}

output "device" {
  value       = nxos_loopback_interface.l3LbRtdIf.device
  description = "A device name from the provider configuration."
}

output "id" {
  value       = nxos_loopback_interface.l3LbRtdIf.interface_id
  description = "Interface ID."
}

output "ipv4_address" {
  value       = length(nxos_ipv4_interface_address.ipv4Addr) > 0 ? nxos_ipv4_interface_address.ipv4Addr[0].address : ""
  description = "Interface IPv4 address."
}
