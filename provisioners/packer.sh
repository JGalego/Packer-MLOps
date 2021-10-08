#!/bin/sh -ex

########################################################################
# Install Packer                                                       #
#                                                                      #
# For more information, please visit:                                  #
# https://learn.hashicorp.com/tutorials/packer/getting-started-install #
########################################################################

# Update package index
apt-get update

# Install unzip
apt-get install unzip

# Download Packer
wget "https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip"

# Install Packer
unzip "packer_${PACKER_VERSION}_linux_amd64.zip"
mv packer /usr/local/bin/
rm "packer_${PACKER_VERSION}_linux_amd64.zip"

# Test Packer installation
packer --version
