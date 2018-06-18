resource "digitalocean_loadbalancer" "devops-demo" {
  name = "plazi-html-v2"
  region = "sfo2"

  forwarding_rule {
    entry_port = 80
    entry_protocol = "http"

    target_port = 3000
    target_protocol = "http"
  }

  healthcheck {
    port = 3000
    protocol = "http"
    path  = "/"
  }

  droplet_tag = "${digitalocean_tag.devops-demo.name}"
}

resource "digitalocean_tag" "devops-demo" {
  name = "platzi-html"
}

resource "digitalocean_droplet" "devops-demo" {
  image  = "${var.image_id}"
  name   = "platzi-demo-v2"
  region = "sfo2"
  size   = "512mb"
  ssh_keys = [21651223]
  tags = ["${digitalocean_tag.devops-demo.id}"]

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    command = "sleep 160 & curl ${self.ipv4_address}:3000"
  }

  user_data = <<EOF
#cloud-config
coreos:
  units:
    - name: "platzi.service"
      command: "start"
      content: |
        [Unit]
        Description=Platzi Demo
        After=docker.service

        [Service]
        ExecStart=/usr/bin/docker run -d -p 3000:3000 platzi
EOF
}
