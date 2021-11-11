<!-- BEGIN_PKR_DOCS -->
# Packer for MLOps

[![MLOps](https://github.com/JGalego/Packer-MLOps/actions/workflows/mlops.yml/badge.svg)](https://github.com/JGalego/Packer-MLOps/actions/workflows/mlops.yml)

<img src="baby_bender.gif" width="300"/>

[Packer](https://www.packer.io/) template for [MLOps](https://ml-ops.org/) practitioners.

This template generates an Ubuntu-based development environment that includes both standard DevOps tools and ML engineering tools.

> **Warning:** This project is a work in progress 🚧 Use with caution!

<!--
**Tools:**
* [Ansible](https://www.ansible.com/)
* [AWS CLI](https://aws.amazon.com/cli/)
* [Azure CLI](https://docs.microsoft.com/en-us/cli/azure)
* [Docker](https://www.docker.com/)
* [DVC](https://dvc.org)
* [Python 3](https://www.python.org/downloads/)
* [Molecule](https://molecule.readthedocs.io/en/stable/)
* [Terraform](https://www.terraform.io/)
* [Vagrant](https://www.vagrantup.com/)
* [VirtualBox](https://www.virtualbox.org/)
* [VS Code](https://code.visualstudio.com/)
* *And many, many more...*
-->
## Setup

### Build

**Requirements:**

* [Packer](https://packer.io) `>= 1.7.6`
* [Vagrant](https://www.vagrantup.com/) `>= 2.2.18`
* [VirtualBox](https://www.virtualbox.org/) `>= 6.1`

Build the image:

> **Note:** This will create an import file (`.ovf`), a disk image (`.vmdk`) and a Vagrant box.

```bash
packer build mlops.pkr.hcl
```

### Run

Once the build is complete, import the image to VirtualBox:

* Go to **File > Import Appliance...**
* In the **Appliance to import** menu, select the `.ovf` file and click `Next`.
* In the **Appliance settings** menu, review the VM attributes and click `Import`.

or run it through [Vagrant](https://www.vagrantup.com/):

```bash
vagrant up
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_http_proxy"></a> [http_proxy](#input_http_proxy) | HTTP proxy configuration (`<host>:<port>`) | `string` | `""` | no |
| <a name="input_https_proxy"></a> [https_proxy](#input_https_proxy) | HTTPS proxy configuration (`<host>:<port>`) | `string` | `""` | no |
| <a name="input_packages"></a> [packages](#input_packages) | Version info for the installer scripts | `map(string)` | <pre>{<br>  "ansible": "2.10.7",<br>  "awscli": "1.20.56",<br>  "azurecli": "2.28.0-1",<br>  "dvc": "2.7.4",<br>  "gcloud": "360.0.0-0",<br>  "kubectl": "1.22.2",<br>  "molecule": "3.5.2",<br>  "nodejs": "14.18.0",<br>  "nvm": "0.39.0",<br>  "packer": "1.7.6",<br>  "terraform": "1.0.8",<br>  "vagrant": "2.2.18",<br>  "virtualbox": "6.1.26",<br>  "vscode": "1.60.2"<br>}</pre> | no |
| <a name="input_password"></a> [password](#input_password) | Default box password for authentication | `string` | `"vagrant"` | no |
| <a name="input_username"></a> [username](#input_username) | Default box username for authentication | `string` | `"vagrant"` | no |
| <a name="input_vbox_opts"></a> [vbox_opts](#input_vbox_opts) | Default VirtualBox options <br><br> Full list of VM settings is available [here](https://www.virtualbox.org/manual/ch08.html#vboxmanage-modifyvm) | `map(string)` | <pre>{<br>  "accelerate_3d": "on",<br>  "disk_size": 40960,<br>  "graphics_controller": "vmsvga",<br>  "headless": "true",<br>  "mem_size": 3072,<br>  "nested_hw_virt": "on",<br>  "num_cpus": 2,<br>  "rtc_use_utc": "on",<br>  "video_mem_size": 64<br>}</pre> | no |

## Troubleshooting

* Boot command is not being typed correctly?

    > Set the environment variable `PACKER_KEY_INTERVAL` (defaults to `100ms`). For more information, please check [this](https://github.com/hashicorp/packer/issues/6247) issue.

## References

* (GitHub) [visenger/awesome-mlops](https://github.com/visenger/awesome-mlops) - an awesome list of references for MLOps - Machine Learning Operations
<!-- END_PKR_DOCS -->