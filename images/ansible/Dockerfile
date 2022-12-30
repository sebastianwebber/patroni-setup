FROM python:3-slim-buster

RUN \
    pip3 install ansible==7.1.0 && \
    apt update && \
    apt install -y openssh-client && \
    rm -rf /var/lib/apt/lists/*