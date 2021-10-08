#!/bin/sh -ex

######################################################################
# Install Terraform                                                  #
#                                                                    #
# For more information, please visit:                                #
# https://learn.hashicorp.com/terraform/getting-started/install.html #
######################################################################

# Update package index
apt-get update

# Install unzip
apt-get install unzip

# Download Terraform
wget "https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Install Terraform
unzip "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
mv terraform /usr/local/bin/
rm "terraform_${TERRAFORM_VERSION}_linux_amd64.zip"

# Test Terraform installation
terraform version
