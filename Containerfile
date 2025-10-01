#FROM quay.io/fedora/fedora-bootc:latest
#COPY 3rd_party.repo /etc/yum.repos.d/
#COPY script.sh /
#RUN chmod +x /script.sh && /script.sh; rm /script.sh
#RUN bootc container lint
#-------------

FROM quay.io/fedora/fedora:latest AS builder

WORKDIR /tmp
RUN /brew.sh





FROM scratch AS ctx
COPY --chmod=755 script.sh /
COPY --chmod=755 brew.sh /

# Base Image
FROM quay.io/fedora/fedora-bootc:latest
COPY 3rd_party.repo /etc/yum.repos.d/
COPY --chmod=755 /ctx/brew /
COPY --from=builder --chown=1000:1000 /home/linuxbrew /usr/share/homebrew

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/script.sh

COPY --chmod=755 /builder/textfile.txt /
RUN cat textfile.txt

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
