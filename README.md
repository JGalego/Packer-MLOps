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

## Troubleshooting

* Boot command is not being typed correctly?

    > Set the environment variable `PACKER_KEY_INTERVAL` (defaults to `100ms`). For more information, please check [this](https://github.com/hashicorp/packer/issues/6247) issue.
