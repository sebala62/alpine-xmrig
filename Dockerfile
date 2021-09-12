FROM  alpine:latest
RUN   adduser -S -D -H -h /xmrig miner
RUN   apk --no-cache upgrade && \
      apk --no-cache add hwloc hwloc-dev --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ && \
      apk --no-cache add \
        git \
        cmake \
        libuv-dev \
        openssl-dev \
        libmicrohttpd-dev \
        build-base && \
      git clone https://github.com/xmrig/xmrig && \
      cd xmrig && \
      mkdir build && \
      cmake -DCMAKE_BUILD_TYPE=Release . && \
      make && \
      apk del \
        build-base \
        cmake \
        git
USER miner
WORKDIR    /xmrig
ENTRYPOINT  ["./xmrig"]
CMD ["-o","europe.cryptonight-hub.miningpoolhub.com:17024","-u","sebala.vm","-p","x","-k","--donate-level","1","--coin","monero"]

