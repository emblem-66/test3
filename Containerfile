#FROM quay.io/fedora/fedora-bootc:42
FROM quay.io/fedora-ostree-desktops/base-atomic:42

RUN bootc container lint
