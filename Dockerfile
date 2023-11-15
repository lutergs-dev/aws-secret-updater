FROM alpine AS Downloader

RUN apk --no-cache add curl unzip

WORKDIR /

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-aarch64.zip" -o "awscliv2.zip" && \
    unzip awscliv2.zip && \
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/arm64/kubectl"

FROM ubuntu:22.04

COPY ./run.sh /root/run.sh
COPY --from=Downloader /aws /root/aws
COPY --from=Downloader /kubectl /root/kubectl

WORKDIR /root

RUN ./aws/install && \
    chmod 755 /root/run.sh && \
    chmod 755 /root/kubectl

CMD ["/bin/bash", "/root/run.sh"]



