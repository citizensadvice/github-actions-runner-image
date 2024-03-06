FROM ghcr.io/actions/actions-runner:latest
USER 0
RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y curl python3-pip && \
    rm -rf /var/cache/apt/*
RUN apt update && \
    apt install -y ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt update && \
    apt install nodejs -y && \
    rm -rf /var/cache/apt/*

USER 1001
ENV PATH "$PATH:/home/runner/.local/bin"
