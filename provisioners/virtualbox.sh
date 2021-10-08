#!/bin/sh -ex

# Download VirtualBox guest additions
test -z "$VIRTUALBOX_VERSION" && VIRTUALBOX_VERSION=$(cat "$HOME/.vbox_version")
test "$VIRTUALBOX_WITH_XORG" = "1" || VIRTUALBOX_WITHOUT_XORG=--nox11
VBOX_GUEST_ADDITIONS_ISO=VBoxGuestAdditions_$VIRTUALBOX_VERSION.iso
test -f "$VBOX_GUEST_ADDITIONS_ISO" || wget "http://download.virtualbox.org/virtualbox/$VIRTUALBOX_VERSION/$VBOX_GUEST_ADDITIONS_ISO"

# Install dependencies
apt-get install -y build-essential
apt-get install -y linux-headers-"$(uname -r)"
apt-get install -y dkms

# Mout VirtualBox guest additions ISO
cd /tmp
mount -o loop "/home/${USERNAME}/$VBOX_GUEST_ADDITIONS_ISO" /mnt
sh /mnt/VBoxLinuxAdditions.run $VIRTUALBOX_WITHOUT_XORG || true
umount /mnt
rm -rf "/home/${USERNAME:?}/$VBOX_GUEST_ADDITIONS_ISO"
