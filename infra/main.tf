resource "digitalocean_droplet" "devops-demo" {
  image  = "35366897"
  name   = "platzi-demo-v2"
  region = "sfo2"
  size   = "512mb"
  ssh_keys = [21651223]
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
