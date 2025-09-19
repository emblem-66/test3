FROM quay.io/fedora/fedora-bootc:42
#FROM quay.io/fedora-ostree-desktops/base-atomic:42
RUN dnf copr enable -y ryanabx/cosmic-epoch && dnf install -y cosmic-desktop
RUN bootc container lint
