variable "device" {
  description = "A device name from the provider configuration."
  type        = string
  default     = null
}

variable "id" {
  description = "Interface ID. Allowed format: `1`."
  type        = number

  validation {
    condition     = try(var.id >= 0 && var.id <= 1023, false)
    error_message = "Minimum value: 0. Maximum value: 1023."
  }
}

variable "admin_state" {
  description = "Administrative port state. Set `true` for `up` or `false` for `down`."
  type        = bool
  default     = true
}

variable "description" {
  description = "Interface description."
  type        = string
  default     = ""

  validation {
    condition     = can(regex("^.{0,254}$", var.description))
    error_message = " Maximum characters: 254."
  }
}

variable "vrf" {
  description = "VRF Name."
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,32}$", var.vrf))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 32."
  }
}

variable "ipv4_address" {
  description = "Interface IPv4 address. Allowed format: `192.168.0.1/24`."
  type        = string
  default     = null

  validation {
    condition     = var.ipv4_address == null || can(regex("^\\d+\\.\\d+\\.\\d+\\.\\d+\\/\\d+$", var.ipv4_address))
    error_message = "Allowed characters: `0`-`9`, `.`, `/`."
  }
}
