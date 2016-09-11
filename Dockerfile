# Dockerfile for Bitcoind

FROM phusion/baseimage:0.9.19
MAINTAINER HyperWang <hyperwangee@gmail.com>

# use aliyun source
ADD sources-aliyun.com.list /etc/apt/sources.list

RUN apt-get update
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config libssl-dev libevent-dev bsdmainutils yasm
RUN apt-get install -y libboost-all-dev libzmq3-dev curl wget

# build bitcoind
RUN mkdir ~/source
RUN cd ~/source && wget https://github.com/bitcoin/bitcoin/archive/v0.12.1.tar.gz -O v0.12.1.tar.gz
RUN cd ~/source \
  && tar zxf v0.12.1.tar.gz && cd bitcoin-0.12.1 \
  && ./autogen.sh \
  && ./configure --disable-wallet \
  && make -j4 && make install
RUN rm -rf ~/source

# clean
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# mkdir bitcoind data dir and run
WORKDIR /root/
RUN mkdir -p .bitcoin
ADD run.py run.py
CMD ["python", "run.py"]
