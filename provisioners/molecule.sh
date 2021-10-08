#!/bin/sh -ex

################################################################
# Install Molecule                                             #
#                                                              #
# For more information, please visit:                          #
# https://molecule.readthedocs.io/en/stable/installation.html  #
################################################################

# Update package index
apt-get update

# Install cryptography dependencies
apt-get install -y libffi-dev musl-dev libssl-dev cargo

# Install molecule + docker driver
python3 -m pip install --upgrade --user rust
python3 -m pip install --upgrade --user setuptools
python3 -m pip install --upgrade --user setuptools-rust
python3 -m pip install molecule[docker]=="$MOLECULE_VERSION"

# Test molecule installation
molecule --version
