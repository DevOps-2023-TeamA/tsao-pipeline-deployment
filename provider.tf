terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "do_token" {}
variable "pvt_key" {}
variable "cloudflare_api_token" {
  description = "The email associated with the Cloudflare account"
  type        = string
}
variable "cloudflare_zone_id" {
  description = "The Zone ID for the Cloudflare managed domain"
  type        = string
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform" {
  name = "jiachen-terraform"
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}