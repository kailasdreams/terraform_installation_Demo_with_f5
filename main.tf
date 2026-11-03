
# Create HTTP health monitor

resource "bigip_ltm_monitor" "http_monitor" {
  name     = "/Common/http_monitor"
  parent   = "/Common/http"
  interval = 5
  timeout  = 16
}

# Create backend server pool

resource "bigip_ltm_pool" "web_pool" {
  name                   = "/Common/web_pool"
  load_balancing_mode    = "round-robin"
  monitors               = [bigip_ltm_monitor.http_monitor.name]
}

# Add backend server 1

resource "bigip_ltm_pool_attachment" "server1" {
  pool       = bigip_ltm_pool.web_pool.name
  node       = "10.10.20.11:80"
  depends_on = [bigip_ltm_pool.web_pool]
}

# Add backend server 2

resource "bigip_ltm_pool_attachment" "server2" {
  pool       = bigip_ltm_pool.web_pool.name
  node       = "10.10.20.12:80"
  depends_on = [bigip_ltm_pool.web_pool]
}

# Create Virtual Server (VIP)

resource "bigip_ltm_virtual_server" "https_vip" {
  name        = "/Common/${var.vip_name}"
  destination = "${var.vip_address}"
  port        = 443
  ip_protocol = "tcp"

  pool = bigip_ltm_pool.web_pool.name

  profiles = [
    "/Common/tcp"
  ]

  source_address_translation = "automap"

  depends_on = [
    bigip_ltm_pool_attachment.server1,
    bigip_ltm_pool_attachment.server2
  ]
}

