FROM ghcr.io/actions/actions-runner:latest

USER 0

RUN apt update && \
    apt dist-upgrade -y && \
    apt install -y curl python3-pip git unzip && \
    rm -rf /var/cache/apt/*

RUN apt update && \
    apt install -y ca-certificates gnupg && \
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt update && \
    apt install nodejs -y && \
    rm -rf /var/cache/apt/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    rm -rf aws*

RUN curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /bin/kubectl && \
    chmod +x /bin/kubectl

RUN npm i -g aws-cdk

RUN curl -L 'https://download.docker.com/linux/static/stable/x86_64/docker-25.0.4.tgz' -o docker.tar.gz && \
    tar xf docker.tar.gz && \
    mv docker/* /usr/bin/ && \
    rm docker* -r

USER 1001

RUN mkdir -p /home/runner/.local/bin
ENV PATH "$PATH:/home/runner/.local/bin"
