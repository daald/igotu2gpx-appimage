FROM ubuntu:14.04

RUN apt-get update \
 && apt-get install -y \
        build-essential \
        cmake \
        libqt4-dev \
        libqt4-dev-bin \
        libusb-1.0-0-dev \
	libmarble-dev \
        pkg-config \
        qt4-qmake \
 && apt-get clean

#ADD deb /tmp/
#RUN dpkg -i 

RUN apt-get install -y \
	libboost-all-dev

RUN apt-get install -y \
	gdb


#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/other/libshp1_1.2.10-7_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/other/libquazip0_0.6.2-0ubuntu1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/other/libqextserialport1_1.2.0~rc1+git7-g3be3fbf-1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/other/libqtlocation1_1.2.0-3ubuntu5_amd64.deb
#
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/libastro-dev_4:4.13.0-0ubuntu1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/marble-plugins_4:4.13.0-0ubuntu1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/libmarblewidget18_4:4.13.0-0ubuntu1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/libmarble-dev_4:4.13.0-0ubuntu1_amd64.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/marble-data_4:4.13.0-0ubuntu1_all.deb
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/marble/libastro1_4:4.13.0-0ubuntu1_amd64.deb
#
#/daten/Projects/oss_community/igotu/2023/buildenv-docker/deb/fake/libgps20_3.9-dummy_all.deb

