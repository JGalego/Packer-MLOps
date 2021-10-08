#!/bin/sh -ex

###############################################
# Install Vagrant                             #
#                                             #
# For more information, please visit:         #
# https://www.vagrantup.com/docs/installation #
###############################################

# Update package index
apt-get update

# Install unzip
apt-get install unzip

# Download Vagrant
wget "https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_linux_amd64.zip"

# Install Vagrant
unzip "vagrant_${VAGRANT_VERSION}_linux_amd64.zip"
mv vagrant /usr/local/bin/
rm "vagrant_${VAGRANT_VERSION}_linux_amd64.zip"

# Test Vagrant installation
vagrant --version

# Install Vagrant support on Python 3
if which python3; then
  python3 -m pip install python-vagrant
fi
