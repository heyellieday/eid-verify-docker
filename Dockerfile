FROM ubuntu:18.04

RUN apt-get update && apt-get -y install cmake libssl1.0-dev xsdcxx libxml-security-c-dev  zlib1g-dev

RUN apt-get -y install git

RUN git clone --recursive https://github.com/open-eid/libdigidocpp && cd libdigidocpp

RUN apt-get -y install xxd

RUN cd libdigidocpp && mkdir build && cd build && cmake ..

RUN cd libdigidocpp/build && make

RUN cd libdigidocpp/build && make install

RUN ldconfig

RUN apt-get -y install curl
