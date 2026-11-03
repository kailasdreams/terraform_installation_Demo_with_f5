
output "vip_name" {
  value = bigip_ltm_virtual_server.https_vip.name
}

output "vip_destination" {
  value = bigip_ltm_virtual_server.https_vip.destination
}

output "backend_pool" {
  value = bigip_ltm_virtual_server.https_vip.pool
}

