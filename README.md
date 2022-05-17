<!-- BEGIN_TF_DOCS -->
[![Tests](https://github.com/netascode/terraform-nxos-interface-loopback/actions/workflows/test.yml/badge.svg)](https://github.com/netascode/terraform-nxos-interface-loopback/actions/workflows/test.yml)

# Terraform NX-OS Loopback Interface Module

Manages NX-OS Loopback Interface

Model Documentation: [Link](https://developer.cisco.com/docs/cisco-nexus-3000-and-9000-series-nx-api-rest-sdk-user-guide-and-api-reference-release-9-3x/#!configuring-a-loopback-interface)

## Examples

```hcl
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
```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_nxos"></a> [nxos](#requirement\_nxos) | >= 0.3.11 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_nxos"></a> [nxos](#provider\_nxos) | >= 0.3.11 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_device"></a> [device](#input\_device) | A device name from the provider configuration. | `string` | `null` | no |
| <a name="input_id"></a> [id](#input\_id) | Interface ID. Allowed format: `1`. | `number` | n/a | yes |
| <a name="input_admin_state"></a> [admin\_state](#input\_admin\_state) | Administrative port state. Set `true` for `up` or `false` for `down`. | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Interface description. | `string` | `""` | no |
| <a name="input_vrf"></a> [vrf](#input\_vrf) | VRF Name. | `string` | `"default"` | no |
| <a name="input_ipv4_address"></a> [ipv4\_address](#input\_ipv4\_address) | Interface IPv4 address. Allowed format: `192.168.0.1/24`. | `string` | `null` | no |
| <a name="input_ipv4_secondary_addresses"></a> [ipv4\_secondary\_addresses](#input\_ipv4\_secondary\_addresses) | List of Interface IPv4 secondary addresses. Allowed format: `192.168.0.1/24`. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dn"></a> [dn](#output\_dn) | Distinguished name of the object. |

## Resources

| Name | Type |
|------|------|
| [nxos_ipv4_interface.ipv4If](https://registry.terraform.io/providers/netascode/nxos/latest/docs/resources/ipv4_interface) | resource |
| [nxos_ipv4_interface_address.ipv4Addr](https://registry.terraform.io/providers/netascode/nxos/latest/docs/resources/ipv4_interface_address) | resource |
| [nxos_ipv4_interface_address.secondary_ipv4Addr](https://registry.terraform.io/providers/netascode/nxos/latest/docs/resources/ipv4_interface_address) | resource |
| [nxos_loopback_interface.l3LbRtdIf](https://registry.terraform.io/providers/netascode/nxos/latest/docs/resources/loopback_interface) | resource |
| [nxos_loopback_interface_vrf.nwRtVrfMbr](https://registry.terraform.io/providers/netascode/nxos/latest/docs/resources/loopback_interface_vrf) | resource |
<!-- END_TF_DOCS -->