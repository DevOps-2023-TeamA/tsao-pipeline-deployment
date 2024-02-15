resource "digitalocean_droplet" "backend" {
  image = "ubuntu-20-04-x64"
  name = "backend"
  region = "sgp1"
  size = "s-1vcpu-1gb"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]
  # user_data = file("${path.module}/backend-init.yml")
  
  connection {
    host = self.ipv4_address
    user = "root"
    type = "ssh"
    private_key = file(var.pvt_key)
    timeout = "2m"
  }

  provisioner "remote-exec" {
    inline = [
      "export PATH=$PATH:/usr/bin",
      
      # install nginx
      "sudo apt update",
      "sudo apt install -y nginx",
      "sudo apt install -y mysql-server",
      "sudo apt install -y git golang",
      
      "sudo ufw allow 22/tcp",
      "sudo ufw allow 8000/tcp",
      "sudo ufw allow 8001/tcp",
      "sudo ufw allow 8002/tcp",
      # "sudo ufw --force enable",
      "sudo ufw reload"
    ]
  } 
}

resource "cloudflare_record" "tsao_backend_record" {
  zone_id = var.cloudflare_zone_id // The Zone ID for "hotchocolate.app"
  name    = "tsao-backend"         // The subdomain part
  value   = digitalocean_droplet.backend.ipv4_address // The Droplet's IP address
  type    = "A"                    // A record for IPv4 address
  ttl     = 1                      // 1 for automatic TTL
  proxied = false                  // Set to true if you want Cloudflare's protection and CDN, false otherwise
}
