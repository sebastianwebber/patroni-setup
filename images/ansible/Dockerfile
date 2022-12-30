FROM python:3-slim-buster

LABEL org.opencontainers.image.description ansible image to use with vagrant
LABEL org.opencontainers.image.version 7.1.0

RUN \
    pip3 install ansible==7.1.0 && \
    apt update && \
    apt install -y openssh-client && \
    rm -rf /var/lib/apt/lists/*