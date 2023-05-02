#!/bin/sh

set -e -x

docker build -t igotugps-buildenv-2023 buildenv-docker

mkdir -p tools/
wget https://github.com/linuxdeploy/linuxdeploy/releases/download/1-alpha-20220822-1/linuxdeploy-x86_64.AppImage -O tools/linuxdeploy-x86_64.AppImage
chmod +x tools/linuxdeploy-x86_64.AppImage

rm -rf build/
mkdir -p build/

docker run --rm \
  -v "$(pwd):/workspace/src:ro" \
  -v "$(pwd)/build:/workspace/build" \
  -w '/workspace' \
  -u "$(id -u)" \
  igotugps-buildenv-2023 sh -xec "
    cd build/
    tar xJf /workspace/src/src/igotu2gpx_bzr227.tar.xz
    cd igotu2gpx
    patch -Np1 </workspace/src/src/y2016.patch
    patch -Np1 </workspace/src/src/marbledatadir.patch

    echo 'CLEBS_DISABLED *= src/connections/libusb10connection' >localconfig.pri  # libusb1 doesn't work
    #echo 'CLEBS_DISABLED *= src/connections/libusbconnection' >localconfig.pri  # libusb0.1 doesn't work either?
    # Uncomment for release version
    echo 'RELEASE = 1' >>localconfig.pri

    qmake
    make clean all
    cd /workspace/build/igotu2gpx

    mkdir -p AppDir/usr/lib/
    ln -s ./ AppDir/usr/lib/igotu2gpx
    tar cC /usr/lib/ kde4/plugins/ | tar xC AppDir/usr/lib/
    tar cC /usr/ share/kde4/apps/marble/ | tar xC AppDir/usr/

    cc /workspace/src/extra/igotugui-launcher.c -o igotugui-launcher

    params=''
    for f in data/icons/*/apps/igotu2gpx-gui.png; do params=\"\$params -i \$f\";done
    for f in bin/release/lib*.so; do params=\"\$params --library=\$f\";done

    export LD_LIBRARY_PATH=\"/workspace/build/igotu2gpx/bin/release:\$LD_LIBRARY_PATH\"
    /workspace/src/tools/linuxdeploy-x86_64.AppImage --appimage-extract-and-run \
      --appdir AppDir \
      -e igotugui-launcher \
      -e bin/release/igotugui \
      --library=/lib/x86_64-linux-gnu/libssl.so.1.0.0 \
      --library=/lib/x86_64-linux-gnu/libusb-0.1.so.4 \
      \$params \
      -d /workspace/src/extra/igotugui.desktop \
      --output appimage
  "

cp -v ./build/igotu2gpx/*.AppImage igotugui-x86_64.AppImage

# testrun
./igotugui-x86_64.AppImage
