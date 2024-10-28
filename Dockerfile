FROM alpine

ARG TARGETARCH

WORKDIR /

# install aws-cli
RUN apk add --no-cache python3 py3-pip && \
    python3 -m venv /python-venv && \
    . /python-venv/bin/activate && \
    pip3 install --upgrade awscli

# install kubectl
RUN if [ "$TARGETARCH" = "arm64" ]; then \
        KUBECTL_ARCH="arm64"; \
    elif [ "$TARGETARCH" = "amd64" ]; then \
        KUBECTL_ARCH="amd64"; \
    else \
        echo "Unsupported architecture: $TARGETARCH"; exit 1; \
    fi && \
    apk add --no-cache curl && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/$KUBECTL_ARCH/kubectl" &&  \
    chmod +x kubectl && \
    mv kubectl /usr/local/bin

# setup script
COPY ./run.sh /run.sh
RUN chmod +x /run.sh

CMD ["/bin/sh", "/run.sh"]
