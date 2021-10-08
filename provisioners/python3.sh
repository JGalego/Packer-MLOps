#!/bin/sh -ex

# Update package index
apt-get update

# Install python3 and python3 -m pip
apt-get install -y python3-dev python3-pip

# Test python3 installation
python3 --version

# Test pip installation
python3 -m pip --version

# Install requirements
python3 -m pip install -r /tmp/requirements.txt
