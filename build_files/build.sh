#!/bin/bash

set -ouex pipefail

### Install packages

# RPMFusion for goodies
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

# Install Terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Install GNOME
dnf5 -y install @gnome-desktop
systemctl enable gdm

# Install Chromium
dnf5 -y install chromium fedora-chromium-config

# Keyd for cb keyboard mapping
dnf5 -y install keyd
systemctl enable keyd

# Install linuxbrew
mkdir /etc/skel/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /etc/skel/homebrew
echo 'export PATH="$HOME/homebrew/bin:$PATH"' >> /etc/skel/.bash_profile

# Init Skel
cp -Rvf /etc/skel/*  /var/home/*/ || true
cp -Rvf /etc/skel/.* /var/home/*/
