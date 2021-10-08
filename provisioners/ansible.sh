#!/bin/sh -ex

#######################################################################################
# Install Ansible                                                                     #
#                                                                                     #
# For more information, please visit:                                                 #
# https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html  #
#######################################################################################

# Install ansible
python3 -m pip install ansible=="$ANSIBLE_VERSION"

# Test ansible installation
ansible --version
