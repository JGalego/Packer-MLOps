#!/bin/sh -ex

#################################################################
# Install Kubectl                                               #
#                                                               #
# For more information, please visit:                           #
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/ #
#################################################################

# Download kubectl
curl -LO "https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"

# Validate binary
curl -LO "https://dl.k8s.io/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256) kubectl" | sha256sum --check

# Install kubectl
install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# Test installation
kubectl version --client