FROM ubuntu:17.04
MAINTAINER Sami Mäkelä

ENV PATH="${PATH}:/node-v6.11.3-linux-x64/bin"

RUN apt-get update && \
  apt-get install -y wget ocaml opam libzarith-ocaml-dev m4 pkg-config zlib1g-dev && \
  opam init -y

RUN apt-get install -y curl && \
  curl -sL https://deb.nodesource.com/setup_6.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g ethereumjs-testrpc && \
  cd bin && \
  wget https://github.com/ethereum/solidity/releases/download/v0.4.16/solc-static-linux && \
  mv solc-static-linux solc && \
  chmod 744 solc

RUN wget https://dist.ipfs.io/go-ipfs/v0.4.10/go-ipfs_v0.4.10_linux-amd64.tar.gz && \
  tar xf go-ipfs_v0.4.10_linux-amd64.tar.gz && \
  cd go-ipfs && \
  ./install.sh && \
  ipfs init

RUN eval `opam config env` && \
   opam install cryptokit -y

RUN wget -O getparity.sh https://get.parity.io && \
   apt-get install -y psmisc sudo && \
   bash getparity.sh && \
   (parity --chain dev &) && \
   sleep 10 && \
   killall parity

#RUN apt-get install -y sudo libudev-dev && \
#   wget https://sh.rustup.rs -O rustup.sh && \
#   sh rustup.sh -y

#RUN apt-get install -y libssl-dev && \
#   eval $(cat /root/.cargo/env) && \
#   git clone https://github.com/paritytech/parity && \
#   cd parity && \
#   cargo build --release && \
#   cp target/release/parity /usr/local/bin

RUN git clone https://github.com/TrueBitFoundation/ocaml-offchain webasm && \
   cd webasm/interpreter && \
   eval `opam config env` && \
   make && \
   ./wasm -m ../test/core/fac.wast

RUN git clone https://github.com/TrueBitFoundation/webasm-solidity && \
  cd webasm-solidity && \
  npm install && \
  sh test.sh

RUN apt-get install -y apache2

EXPOSE 80 22448

RUN cd webasm-solidity && git pull && \
  cp app.html /var/www/html/index.html && \
  cp socketio.js /var/www/html/

ENTRYPOINT cd webasm-solidity && sh start.sh

