#!/bin/bash

set -ouex pipefail

### Install packages

# RPMFusion for goodies
dnf5 -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-42.noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-42.noarch.rpm

# Install GNOME
dnf5 -y install @gnome-desktop
systemctl enable gdm

# Install Chrome
echo '[google-chrome]
name=google-chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub' | tee /etc/yum.repos.d/google-chrome.repo
dnf5 -y install google-chrome-stable

# Keyd for cb keyboard mapping
dnf5 -y copr enable alternateved/keyd
dnf5 -y install keyd
dnf5 -y copr disable alternatived/keyd
systemctl enable keyd

# Install linuxbrew
mkdir /etc/skel/homebrew && curl -L https://github.com/Homebrew/brew/tarball/master | tar xz --strip 1 -C /etc/skel/homebrew
echo 'export PATH="$HOME/homebrew/bin:$PATH"' >> /etc/skel/.bash_profile

# Init Skel
cp -Rvf /etc/skel/*  /var/home/*/ || true
cp -Rvf /etc/skel/.* /var/home/*/
