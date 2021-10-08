#!/bin/sh -ex

# Installing Kubuntu Desktop & its Dependencies
apt-get -y install xorg xrdp build-essential tasksel
DEBIAN_FRONTEND=noninteractive tasksel install kubuntu-desktop
service xrdp restart

# Setting Up Kubuntu Desktop
apt-get -y install nemo gedit
xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
apt-get -y purge dolphin kate gwenview
xdg-mime default gedit.desktop text/plain
rm -f /*/Desktop/trash.desktop
rm -f /*/*/Desktop/trash.desktop
apt-get autoclean
apt-get autoremove