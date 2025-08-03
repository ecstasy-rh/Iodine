#!/bin/bash

set -ouex pipefail

### Install packages

# RPMFusion for goodies
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

# Install Terra
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release

# Use vanilla kernel for faster updates and more universal device support
dnf5 -y copr enable @kernel-vanilla/stable
dnf5 -y upgrade 'kernel*'
dnf5 -y copr disable @kernel-vanilla/stable

# Install GNOME
dnf5 -y install @gnome-desktop
systemctl enable gdm

# Install Chromium
dnf5 -y install chromium fedora-chromium-config
dnf5 -y remove firefox

# Keyd for cb keyboard mapping
dnf5 -y install keyd
systemctl enable keyd

# Install linuxbrew
mkdir /etc/skel/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /etc/skel/homebrew
echo 'export PATH="$HOME/homebrew/bin:$PATH"' >> /etc/skel/.bash_profile
