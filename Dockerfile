FROM ghcr.io/actions/actions-runner:latest
USER 0
RUN apt update && \
    apt install -y curl python3-pip
USER 1001
