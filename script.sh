#!/bin/bash
set -xeuo pipefail

# hardware/drivers
#dnf install -y \
#    kernel-modules-extra \
#    iwlwifi-mvm-firmware \
#    alsa-sof-firmware \
#    blueman \
#    NetworkManager-wifi \
#    NetworkManager-openvpn-gnome \
#    powertop \
#    wpa_supplicant

# shell tools and development
#dnf install -y \
#    cyrus-sasl-plain \
#    fpaste \
#    git \
#    glibc-langpack-de \
#    glibc-langpack-en \
#    isync \
#    krb5-workstation \
#    man-db \
#    mtr \
#    mutt  \
#    neovim \
#    nmap-ncat \
#    restic \
#    rsync \
#    strace \
#    syncthing \
#    systemd-container \
#    toolbox \
#    tree \
#    w3m \
#    wget

rpm -qa | sort

# GNOME desktop
#dnf install -y \
#    gdm \
#    gnome-shell \
#    nautilus \
#    ptyxis \
#    gnome-disk-utility \
#    adw-gtk3-theme

# graphical target
#systemctl set-default graphical.target

# desktop plumbing/apps
#dnf install -y flatpak

#dnf remove -y \

#rpm -qa 'qemu-user-static*' | xargs dnf remove -y

#dnf clean all

#rpm -e --verbose dnf dnf-data python3-dnf
