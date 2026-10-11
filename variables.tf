variable "oda_oda_private_endpoint_scan_proxies" {
  description = <<EOT
Map of oda_oda_private_endpoint_scan_proxies, attributes below
Required:
    - oda_private_endpoint_id
    - protocol
    - scan_listener_type
    - scan_listener_infos (block):
        - scan_listener_fqdn (optional)
        - scan_listener_ip (optional)
        - scan_listener_port (optional)
Optional:
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    oda_private_endpoint_id = string
    protocol                = string
    scan_listener_type      = string
    scan_listener_infos = list(object({
      scan_listener_fqdn = optional(string)
      scan_listener_ip   = optional(string)
      scan_listener_port = optional(number)
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.oda_oda_private_endpoint_scan_proxies : (
        length(v.scan_listener_infos) >= 1
      )
    ])
    error_message = "Each scan_listener_infos list must contain at least 1 items"
  }
}

