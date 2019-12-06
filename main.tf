variable "environment" {
}

provider "digitalocean" {}

resource "digitalocean_droplet" "app-srv" {
    name  = "app-srv-${var.environment}"
    image = "docker-18-04"
    region = "fra1"
    #size = "s-3vcpu-1gb"
    size = "s-2vcpu-4gb"
    ssh_keys = [25503420,24397269]
	user_data = "${file("./user-data.yml")}"
    monitoring = true
}

resource "digitalocean_project" "app-srv" {
    name        = "APP-SRV-${var.environment}"
    description = "APP-SRV"
    purpose     = "Web Application"
    resources   = [digitalocean_droplet.app-srv.urn]
}
