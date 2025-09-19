FROM quay.io/fedora/fedora-bootc:42
#FROM quay.io/fedora-ostree-desktops/base-atomic:42
RUN dnf install -y dnf5-plugins && dnf autoremove -y && dnf clean all
RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y cosmic-desktop && dnf autoremove -y && dnf clean all
RUN dnf config-manager addrepo --from-repofile=https://pkgs.tailscale.com/stable/fedora/tailscale.repo && dnf install -y tailscale && systemctl enable tailscaled.service sshd.service && dnf autoremove -y && dnf clean all
RUN bootc container lint
