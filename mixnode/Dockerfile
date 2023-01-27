FROM rust:slim-bullseye AS builder
ARG NYM_TAG=nym-binaries-v1.1.6
WORKDIR /app
RUN set -ex \
    && apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y libssl-dev pkg-config git tini \
    && git clone https://github.com/nymtech/nym.git \
    && cd ./nym \
    && git checkout tags/${NYM_TAG} \
    && cd ./mixnode \
    && cargo build --release

FROM bitnami/minideb:bullseye
RUN set -ex \
    && install_packages libssl1.1 ca-certificates
VOLUME [ "$HOME/.nym" ]
ENTRYPOINT [ "/tini", "-v", "--" ]
CMD [ "/usr/local/bin/nym-mixnode", "run", "--id", "debaser" ]
COPY --from=builder /app/nym/target/release/nym-mixnode /usr/local/bin/nym-mixnode
COPY --from=builder /usr/bin/tini-static /tini
COPY nym-init.sh /usr/local/bin/nym-init.sh