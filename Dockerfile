FROM ubuntu:18.04

ENV NODE_VERSION=10.8 NVM_VERSION=0.33.11

# Replace shell with bash so we can source files
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# Set debconf to run non-interactively
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && \
    apt-get install -y -q --no-install-recommends \
      mosquitto \
      curl \
      ca-certificates \
      build-essential \
      python \
      git \
      cmake \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v${NVM_VERSION}/install.sh | bash && \
    source /root/.nvm/nvm.sh && \
    nvm install ${NODE_VERSION} && \
    nvm use ${NODE_VERSION}
