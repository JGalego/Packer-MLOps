#!/bin/sh -ex

######################################################################
# Install NVM and node.js                                            #
#                                                                    #
# For more information, please visit:                                #
# https://docs.npmjs.com/downloading-and-installing-node-js-and-npm  #
######################################################################

# Install NVM - version manager for node.js
# https://github.com/nvm-sh/nvm
curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash

# Install node.js
source "$HOME/.bashrc"
nvm install "${NODEJS_VERSION}"