#!/bin/sh -ex

###################################################
# Install Visual Studio Code                      #
#                                                 #
# For more information, please visit:             #
# https://code.visualstudio.com/docs/setup/linux  #
###################################################

# Download VS code
wget -O "vscode-${VSCODE_VERSION}.deb" "https://update.code.visualstudio.com/${VSCODE_VERSION}/linux-deb-x64/stable"

# Install VS code
# https://code.visualstudio.com/docs/setup/linux#_debian-and-ubuntu-based-distributions
apt install -y "./vscode-${VSCODE_VERSION}.deb"

# Cleanup package
rm "./vscode-${VSCODE_VERSION}.deb"
