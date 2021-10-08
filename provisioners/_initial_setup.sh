#!/bin/sh -ex

# Proxy setup (environment variables)
{
    echo "http_proxy=$http_proxy"
    echo "HTTP_PROXY=$http_proxy"
    echo "https_proxy=$https_proxy"
    echo "HTTPS_PROXY=$https_proxy"
} >> /etc/profile.d/set_proxy.sh

# Update archive mirror
sed "s=^\([^#]* \)http://archive.ubuntu.com/ubuntu\( .*\)\$=\1${ARCHIVE_MIRROR:-http://archive.ubuntu.com/ubuntu}\2=" /etc/apt/sources.list > /tmp/sources.list
mv /tmp/sources.list /etc/apt/sources.list

# Update package index
apt-get update

# Install dependencies
apt-get install -y curl

# Comment out requiretty
# For more information, please visit
# https://www.cyberciti.biz/faq/linux-unix-bsd-sudo-sorry-you-must-haveattytorun/
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Setup ssh
# shellcheck disable=SC2174
mkdir -pm 700 "/home/${USERNAME}/.ssh"
curl -kL 'https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub' >> "/home/${USERNAME}/.ssh/authorized_keys"
chmod 0600 "/home/${USERNAME}/.ssh/authorized_keys"
chown -R "$USERNAME:$USERNAME" "/home/$USERNAME/.ssh"
if grep "^UseDNS yes" /etc/ssh/sshd_config; then
  sed "s/^UseDNS yes/UseDNS no/" /etc/ssh/sshd_config > /tmp/sshd_config
  mv /tmp/sshd_config /etc/ssh/sshd_config
else
  echo "UseDNS no" >> /etc/ssh/sshd_config
fi

# Set passwordless sudo for user
echo "${USERNAME} ALL=(ALL) NOPASSWD: ALL" >> "/etc/sudoers.d/${USERNAME}"
chmod 0440 "/etc/sudoers.d/${USERNAME}"

# Add $HOME/.local/bin to PATH
echo "export PATH=$PATH:/home/${USERNAME}/.local/bin" >> .bashrc