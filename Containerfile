FROM quay.io/fedora/fedora-bootc:latest
#FROM quay.io/fedora-ostree-desktops/base-atomic:42
#RUN dnf install -y dnf5-plugins && dnf autoremove -y && dnf clean all
#RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y cosmic-desktop && dnf autoremove -y && dnf clean all
#RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && dnf install -y tailscale && systemctl enable tailscaled.service sshd.service && dnf autoremove -y && dnf clean all

COPY 3rd_party.repo /etc/yum.repos.d/

#RUN dnf install -y tailscale && systemctl enable tailscaled.service && systemctl enable sshd.service && dnf install -y morewaita-icon-theme && rpm -qa 'qemu-user-static*' | xargs dnf remove -y && dnf clean all

COPY script.sh /
RUN chmod +x /script.sh && /script.sh; rm /script.sh

RUN bootc container lint
