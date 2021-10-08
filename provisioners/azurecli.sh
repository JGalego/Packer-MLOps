#!/bin/sh -ex

##########################################################################################
# Install Azure CLI                                                                      #
#                                                                                        #
# For more information, please visit:                                                    #
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest #
##########################################################################################

# Install dependencies
apt-get update
apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

# Download and install the Microsoft signing key
curl -sL https://packages.microsoft.com/keys/microsoft.asc | 
    gpg --dearmor | 
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null

# Add the Azure CLI software repository
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | 
    sudo tee /etc/apt/sources.list.d/azure-cli.list

# Update repository information and install the azure-cli package
apt-get update
apt-get install -y azure-cli="$AZURECLI_VERSION~$AZ_REPO"

# Check installation
az --version