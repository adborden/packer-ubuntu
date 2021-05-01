
source "qemu" "ubuntu" {
  iso_checksum = "sha256:d1f2bf834bbe9bb43faf16f9be992a6f3935e65be0edece1dee2aa6eb1767423"
  iso_urls = [
    "http://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso",
  ]

  output_directory       = "build/ubuntu_2004"
  shutdown_command       = "echo 'ubuntu' | sudo -S shutdown -P now"
  memory                 = 2048
  disk_size              = "5000M"
  format                 = "qcow2"
  accelerator            = "kvm"
  http_directory         = "http"
  ssh_username           = "ubuntu"
  ssh_password           = "ubuntu"
  ssh_timeout            = "45m"
  ssh_handshake_attempts = 500 # during the ubuntu autoinstall, packer will be getting auth errors which is okay
  vm_name                = "focal"
  net_device             = "virtio-net"
  disk_interface         = "virtio"
  boot_wait              = "3s"
  boot_command = [
    "<enter><enter><f6><esc><wait>",
    "<bs><bs><bs><bs>",
    "autoinstall net.ifnames=0 biosdevname=0 ip=dhcp ipv6.disable=1 ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ",
    "--- <enter>"
  ]
}

build {
  name    = "ubuntu"
  sources = ["source.qemu.ubuntu"]

  provisioner "ansible" {
    playbook_file = "ansible/provision.yml"
  }
}
