#!/bin/sh -ex

#######################################
# Install Ansible                     #
#                                     #
# For more information, please visit: #
# https://dvc.org/doc/install/linux   #
#######################################

# Install DVC
# Note: includes all remote storage dependencies
# https://dvc.org/doc/use-cases/sharing-data-and-model-files
# https://dvc.org/doc/command-reference/remote
python3 -m pip install "dvc[all]==$DVC_VERSION"

# Test DVC installation
dvc version