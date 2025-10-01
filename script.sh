#!/bin/bash
set -xeuo pipefail

# tailscale
dnf install -y tailscale

systemctl enable tailscaled.service

systemctl enable sshd.service

# morewaita
dnf install -y morewaita-icon-theme

# hardware/drivers
dnf install -y \
    kernel-modules-extra \
    iwlwifi-mvm-firmware \
    alsa-sof-firmware \
    blueman \
    NetworkManager-wifi \
    NetworkManager-openvpn-gnome \
    powertop \
    wpa_supplicant

# shell tools and development
dnf install -y \
    cyrus-sasl-plain \
    fpaste \
    git \
    glibc-langpack-de \
    glibc-langpack-en \
    isync \
    krb5-workstation \
    man-db \
    mtr \
    mutt  \
    neovim \
    nmap-ncat \
    restic \
    rsync \
    strace \
    syncthing \
    systemd-container \
    toolbox \
    tree \
    w3m \
    wget

# desktop plumbing/apps
dnf install -y \
    flatpak \

# GNOME desktop
dnf install -y \
    gdm \
    gnome-shell \
    nautilus \
    ptyxis \
    gnome-disk-utility \
    adw-gtk3-theme

# graphical target
systemctl set-default graphical.target

#dnf remove -y \

rpm -qa 'qemu-user-static*' | xargs dnf remove -y

dnf clean all

#rpm -e --verbose dnf dnf-data python3-dnf




