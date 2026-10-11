resource "oci_oda_oda_private_endpoint_scan_proxy" "oda_oda_private_endpoint_scan_proxies" {
  for_each = var.oda_oda_private_endpoint_scan_proxies

  oda_private_endpoint_id = each.value.oda_private_endpoint_id
  protocol                = each.value.protocol
  scan_listener_type      = each.value.scan_listener_type

  dynamic "scan_listener_infos" {
    for_each = each.value.scan_listener_infos
    content {
      scan_listener_fqdn = scan_listener_infos.value.scan_listener_fqdn
      scan_listener_ip   = scan_listener_infos.value.scan_listener_ip
      scan_listener_port = scan_listener_infos.value.scan_listener_port
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

