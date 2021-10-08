#!/bin/sh -ex

#######################################
# Install AWS CLI                     #
#                                     #
# For more information, please visit: #
# https://aws.amazon.com/cli/         #
#######################################

# Install AWS CLI
python3 -m pip install awscli=="$AWSCLI_VERSION"

# Test AWS CLI installation
aws --version
