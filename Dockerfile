FROM alpine:latest

# update alpine
RUN apk update && apk upgrade

# add repository to install hwloc-dev
RUN echo 'https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories

# install packages to build the software
RUN apk add git make cmake libstdc++ gcc g++ libuv-dev openssl-dev hwloc-dev

# clone xmrig
RUN git clone https://github.com/xmrig/xmrig

# switch work dir
WORKDIR /xmrig

# build the mining software
RUN mkdir build && cd build && cmake .. && make -j$(nproc)

# add non root user
RUN apk add bash && adduser -S -D -H -s /bin/bash -h /xmrig miner

# switch to the miner user from now on
USER miner

# expose an entry point
ENTRYPOINT ["/xmrig/build/xmrig"]
