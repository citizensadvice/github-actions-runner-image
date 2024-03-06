FROM ghcr.io/actions/actions-runner:latest
USER 0
RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y curl python3-pip npm && \
    rm -rf /var/cache/apt/* 
USER 1001

ENV PATH "$PATH:/home/runner/.local/bin"
