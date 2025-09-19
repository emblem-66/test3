#FROM quay.io/fedora/fedora-bootc:42
FROM quay.io/fedora-ostree-desktops/base-atomic:42
RUN rpm -qa | sort
RUN jq -r .packages[] /usr/share/rpm-ostree/treefile.json
RUN bootc container lint
