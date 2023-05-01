FROM ubuntu:14.04

RUN apt-get update \
 && apt-get install -y \
        build-essential \
        cmake \
        libqt4-dev \
        libqt4-dev-bin \
        libusb-dev \
        libmarble-dev \
        pkg-config \
        qt4-qmake \
        libboost-all-dev \
        gdb \
 && apt-get clean

RUN apt-get install -y \
	libusb-1.0-0-dev:amd64
