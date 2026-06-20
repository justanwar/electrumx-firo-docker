FROM ubuntu:24.04

WORKDIR /
ADD https://github.com/firoorg/electrumx-firo/archive/refs/heads/master.tar.gz /
RUN tar zxvf *.tar.gz
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
    python3 \
    python3-pip \
    python3-dev \
    python3-plyvel && \
    rm -rf /var/lib/apt/lists/*
RUN cd /electrumx* && pip3 install --no-cache-dir --break-system-packages .

ENV SERVICES=ssl://:50002
ENV COIN=Firo
ENV DB_DIRECTORY=/db
ENV DB_ENGINE=leveldb
ENV DAEMON_URL=http://username:password@hostname:8888/
ENV ALLOW_ROOT=true
ENV MAX_SEND=10000000
ENV BANDWIDTH_UNIT_COST=50000
ENV CACHE_MB=2000
VOLUME [/db]
STOPSIGNAL SIGTERM
CMD ["/usr/bin/python3", "/usr/local/bin/electrumx_server"]