#    _     _     _
#  /   \ /   \ /   \
# |  ML / Dev / Ops |
#  \ _ / \ _ / \ _ /
#
# Packer template for MLOps practitioners

packer {
  required_version = ">= 1.7.0"
}

variable "packages" {
  type = map(string)
  default = {
    ansible     = "2.10.7",     # https://github.com/ansible/ansible/releases
    awscli      = "1.20.56",    # https://github.com/aws/aws-cli/releases
    azurecli    = "2.28.0-1",   # https://docs.microsoft.com/en-us/cli/azure/release-notes-azure-cli?tabs=azure-cli
    dvc         = "2.7.4",      # https://github.com/iterative/dvc/releases
    gcloud      = "360.0.0-0"   # https://cloud.google.com/sdk/docs/release-notes
    kubectl     = "1.22.2",     # https://kubernetes.io/releases/
    molecule    = "3.5.2",      # https://github.com/ansible-community/molecule/releases
    nodejs      = "14.18.0"     # https://nodejs.org/en/about/releases/
    nvm         = "0.39.0"      # https://github.com/nvm-sh/nvm/releases
    packer      = "1.7.6",      # https://github.com/hashicorp/packer/releases
    terraform   = "1.0.8",      # https://github.com/hashicorp/terraform/releases
    vagrant     = "2.2.18",     # https://github.com/hashicorp/vagrant/releases
    virtualbox  = "6.1.26"      # https://www.virtualbox.org/wiki/Changelog
    vscode      = "1.60.2"      # https://code.visualstudio.com/updates
  }
}

variable "vbox_opts" {
  type    = map(string)
  default = {
    # Full list of VM settings is available here:
    # https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm
    accelerate_3d = "on",
    disk_size = 40960,
    graphics_controller = "vmsvga",
    headless = "true",
    mem_size = 3072,
    nested_hw_virt = "on",
    num_cpus = 2,
    rtc_use_utc = "on",
    video_mem_size = 64
  }
}

variable "http_proxy" {
  type    = string
  default = ""
}

variable "https_proxy" {
  type    = string
  default = ""
}

variable "username" {
  type    = string
  default = "vagrant"
}

variable "password" {
  type      = string
  sensitive = true
  default   = "vagrant"
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "virtualbox-iso" "mlops" {
  http_content = {
        "/preseed.cfg" = templatefile(
                            "${path.root}/http/preseed.pkrtpl", 
                            {
                              username = var.username,
                              password = var.password,
                              http_proxy = var.http_proxy
                            }
                          ),
        "/requirements.txt" = file("${path.root}/requirements.txt")
  }
  boot_command            = [
                              "<esc><f6><esc>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs><bs><bs><bs><bs><bs><bs><bs>",
                              "<bs><bs><bs>",
                              "/install/linux ",
                              "preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg ",
                              "debian-installer=en_US auto=true locale=en_US kbd-chooser/method=pt ",
                              "console-setup/ask_detect=false keyboard-configuration/layoutcode=pt ",
                              "hostname=vagrant ",
                              "initrd=/install/initrd.gz quiet --- <enter>"
                            ]
  boot_wait               = "10s"
  disk_size               = "${var.vbox_opts["disk_size"]}"
  guest_additions_mode    = "disable"
  guest_os_type           = "Ubuntu_64"
  headless                = "${var.vbox_opts["headless"]}"
  iso_checksum            = "sha256:f11bda2f2caed8f420802b59f382c25160b114ccc665dbac9c5046e7fceaced2"
  iso_urls                = [
                              "./iso/ubuntu-20.04.1-legacy-server-amd64.iso",
                              "http://cdimage.ubuntu.com/ubuntu-legacy-server/releases/20.04/release/ubuntu-20.04.1-legacy-server-amd64.iso"
                            ]
  shutdown_command        = "sudo /sbin/shutdown -h now"
  ssh_password            = "${var.password}"
  ssh_port                = 22
  ssh_pty                 = "true"
  ssh_username            = "${var.username}"
  ssh_wait_timeout        = "10000s"
  vboxmanage              = [
                              ["modifyvm", "{{ .Name }}", "--memory", "${var.vbox_opts["mem_size"]}"],
                              ["modifyvm", "{{ .Name }}", "--cpus", "${var.vbox_opts["num_cpus"]}"],
                              ["modifyvm", "{{ .Name }}", "--rtcuseutc", "${var.vbox_opts["rtc_use_utc"]}"],
                              ["modifyvm", "{{ .Name }}", "--graphicscontroller", "${var.vbox_opts["graphics_controller"]}"],
                              ["modifyvm", "{{ .Name }}", "--vram", "${var.vbox_opts["video_mem_size"]}"],
                              ["modifyvm", "{{ .Name }}", "--nested-hw-virt", "${var.vbox_opts["nested_hw_virt"]}"],
                              ["modifyvm", "{{ .Name }}", "--accelerate3d", "${var.vbox_opts["accelerate_3d"]}"]
                            ]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "mlops-ubuntu-${local.timestamp}"
}

build {
  name = "MLOps"
  description = "Ubuntu-based development environment for MLOps practitioners"
  sources = ["source.virtualbox-iso.mlops"]

  # Copy requirements.txt file to tmp folder
  provisioner "file" {
    source = "${path.root}/requirements.txt"
    destination = "/tmp/"
  }

  provisioner "shell" {
    environment_vars = [ # User settings
                         "USERNAME=${var.username}",
                         # Proxy settings
                         "HTTP_PROXY=${var.http_proxy}",
                         "HTTPS_PROXY=${var.https_proxy}",
                         # Package versions
                         "ANSIBLE_VERSION=${var.packages["ansible"]}",
                         "AWSCLI_VERSION=${var.packages["awscli"]}",
                         "AZURECLI_VERSION=${var.packages["azurecli"]}",
                         "DVC_VERSION=${var.packages["dvc"]}",
                         "GCLOUD_VERSION=${var.packages["gcloud"]}",
                         "KUBECTL_VERSION=${var.packages["kubectl"]}",
                         "MOLECULE_VERSION=${var.packages["molecule"]}",
                         "NODEJS_VERSION=${var.packages["nodejs"]}",
                         "NVM_VERSION=${var.packages["nvm"]}",
                         "PACKER_VERSION=${var.packages["packer"]}",
                         "TERRAFORM_VERSION=${var.packages["terraform"]}",
                         "VAGRANT_VERSION=${var.packages["vagrant"]}",
                         "VSCODE_VERSION=${var.packages["vscode"]}",
                         # VirtualBox settings
                         "VIRTUALBOX_VERSION=${var.packages["virtualbox"]}",
                         "VIRTUALBOX_WITH_XORG=1"
                       ]
    execute_command  = "echo 'vagrant' | {{ .Vars }} sudo -E -S -H sh -ex '{{ .Path }}'"
    scripts          = [
                         "provisioners/_initial_setup.sh",
                         "provisioners/python3.sh",
                         "provisioners/ansible.sh",
                         "provisioners/awscli.sh",
                         "provisioners/azurecli.sh",
                         "provisioners/docker.sh",
                         "provisioners/dvc.sh",
                         "provisioners/gcloud.sh",
                         "provisioners/kubectl.sh",
                         "provisioners/molecule.sh",
                         "provisioners/nodejs.sh",
                         "provisioners/packer.sh",
                         "provisioners/terraform.sh",
                         "provisioners/vagrant.sh",
                         "provisioners/vscode.sh",
                         "provisioners/kde.sh",
                         "provisioners/virtualbox.sh"
                       ]
  }

  # Generate Vagrant box
  post-processor "vagrant" {
    compression_level = 7
  }
}
