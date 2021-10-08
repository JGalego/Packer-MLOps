#!/bin/sh -ex

###########################################################
# Install Docker                                          #
#                                                         #
# For more information, please visit                      #
# https://docs.docker.com/install/linux/docker-ce/ubuntu/ #
###########################################################

# Update the apt package index
apt-get update

# Install packages to allow apt to use a repository over HTTPS
apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

# Add Docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repository
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Update the apt package index
apt-get update

# Install the latest version of Docker CE and containerd
apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose
apt-get install -y docker-compose

# Add user to the docker group
usermod -aG docker "${USERNAME}"
