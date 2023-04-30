#!/bin/sh

set -e -x

docker build -t igotugps-buildenv-2023 buildenv-docker

mkdir -p tools/
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/1-alpha-20220822-1/linuxdeploy-x86_64.AppImage -O tools/linuxdeploy-x86_64.AppImage
chmod +x tools/linuxdeploy-x86_64.AppImage

docker run --rm \
  -v "$(pwd):/workspace/src:ro" \
  -v "$(pwd)/build:/workspace/build" \
  -w '/workspace' \
  igotugps-buildenv-2023 sh -xec "
    cd build/
    tar xJf /workspace/src/src/igotu2gpx_bzr227.tar.xz
    cd igotu2gpx
    patch -Np1 </workspace/src/src/y2016.patch
    patch -Np1 </workspace/src/src/marbledatadir.patch
    qmake
    make clean all

    cd /workspace/build/igotu2gpx

    cc /workspace/src/extra/igotugui-launcher.c -o igotugui-launcher

    export LD_LIBRARY_PATH="/workspace/build/igotu2gpx/bin/debug:$LD_LIBRARY_PATH"
    /workspace/src/tools/linuxdeploy-x86_64.AppImage --appimage-extract-and-run \
      --appdir AppDir \
      -e igotugui-launcher \
      -e bin/debug/igotugui \
      --library=/lib/x86_64-linux-gnu/libssl.so.1.0.0 \
      -i /workspace/build/igotu2gpx/data/icons/128x128/apps/igotu2gpx-gui.png \
      -i /workspace/build/igotu2gpx/data/icons/48x48/apps/igotu2gpx-gui.png \
      -i /workspace/build/igotu2gpx/data/icons/32x32/apps/igotu2gpx-gui.png \
      -i /workspace/build/igotu2gpx/data/icons/64x64/apps/igotu2gpx-gui.png \
      -i /workspace/build/igotu2gpx/data/icons/22x22/apps/igotu2gpx-gui.png \
      -i /workspace/build/igotu2gpx/data/icons/16x16/apps/igotu2gpx-gui.png \
      -d /workspace/src/extra/igotugui.desktop \
      --output appimage

  "
cp -v ./build/igotu2gpx/igotugui-x86_64.AppImage .

# testrun
./igotugui-x86_64.AppImage
