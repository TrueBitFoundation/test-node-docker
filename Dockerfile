FROM ubuntu:17.04
MAINTAINER Sami Mäkelä

ENV PATH="${PATH}"

RUN apt-get update && \
  apt-get install -y wget ocaml opam libzarith-ocaml-dev m4 pkg-config zlib1g-dev && \
  opam init -y

RUN git clone https://github.com/mrsmkl/spec webasm && \
   cd webasm/interpreter && \
   eval `opam config env` && \
   opam install cryptokit -y && \
   make && \
   ./wasm -m ../test/core/fac.wast

RUN apt-get install -y npm && \
  ln -s /usr/bin/nodejs /bin/node && \
  npm install -g ethereumjs-testrpc && \
  cd bin && \
  wget https://github.com/ethereum/solidity/releases/download/v0.4.16/solc-static-linux && \
  mv solc-static-linux solc && \
  chmod 744 solc

RUN cd webasm/solidity && \
  npm install web3 && \
  ./test.sh

