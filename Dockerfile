FROM ubuntu:22.04

COPY ./run.sh ~/run.sh

WORKDIR ~/

RUN apt-get update &&  \
    apt install curl unzip -y && \
    curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    ./aws/install && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl" && \
    chmod 755 ~/run.sh

CMD ["/bin/bash", "~/run.sh"]



