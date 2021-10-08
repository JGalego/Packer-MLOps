#!/bin/sh -ex

#############################################
# Install Google Cloud SDK                  #
#                                           #
# https://cloud.google.com/sdk/docs/install #
#############################################

# Add cloud SDK distribution to package source
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Install dependencies
apt-get install -y apt-transport-https ca-certificates gnupg

# Import Google Cloud public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# Update package index
apt-get update

# Install Cloud SDK
apt-get install -y "google-cloud-sdk=${GCLOUD_VERSION}"
