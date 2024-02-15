resource "digitalocean_firewall" "app_firewall" {
  name = "allow-8000-and-ssh"

  droplet_ids = [
    digitalocean_droplet.backend.id,
  ]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8000"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8001"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "8002"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  # Added rule to allow SSH
  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"  # SSH default port
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "tcp"
    port_range            = "0"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}
