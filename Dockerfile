FROM ubuntu:22.10
MAINTAINER ElXreno <elxreno@gmail.com>

ARG DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y software-properties-common && \
    add-apt-repository -y universe && \
    apt-get install --no-install-recommends -y \
    bc \
    bison \
    brotli \
    ccache \
    ca-certificates \
    curl \
    flex \
    gcc \
    git \
    libc6-dev \
    libssl-dev \
    libncurses5 \
    libfreetype6 \
    make \
    openssl \
    python3 \
    rsync \
    ssh \
    wget \
    zip \
    unzip \
    zstd \
    fontconfig \
    libncurses5-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl https://storage.googleapis.com/git-repo-downloads/repo \
      > /usr/local/bin/repo && chmod a+x /usr/local/bin/repo

RUN update-alternatives --install /usr/bin/python python /usr/bin/python3 10

# Setup user
RUN useradd -r -u 1000 -s /bin/bash -c "Android builder" -d /home/builder builder && \
    mkdir -p /home/builder && \
    chown -R builder:builder /home/builder

ENV USE_CCACHE=1
ENV CCACHE_EXEC=/usr/bin/ccache
ENV CCACHE_DIR=/home/builder/.ccache

WORKDIR /home/builder

USER builder
