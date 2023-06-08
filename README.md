Free GUI utility to provide Linux/Mac OS X support for the MobileAction i-gotU USB GPS travel loggers
=====================================================================================================

![screenshot](extra/screenshot.png)

This repository is not the source itself. It is only the code for building a working AppImage.

Sources
-------

The sources come from https://code.launchpad.net/igotu2gpx, or more exactly from https://bazaar.launchpad.net/~igotu2gpx/igotu2gpx/trunk/revision/227

The License of the original source code, contained in the file src/igotu2gpx_bzr227.tar.xz, is GPLv3

### Patches

I wrote two patches for this:

marbledatadir.patch, to make it possible to change the marble (world map) datafile paths by environment varibles. These variables are set in the launcher extra/igotugui-launcher.c

y2016.patch, the devices store timestamps with a 4-bit year. This means, the numbers 0..15 can be represented. This means that for the device, the years 2000, 2016 and 2032 are the same, and likewise with other years. This patch shifts the year to a plausible value when using after 2016.

Notes
-----

AppImage has extra support for packing qt5 code. Unfortunately, this is qt4 code, and I had to do some hacks to get it working. See build.sh.
This is also the reason why I built this AppImage. The original code compiles for Ubuntu 14.04, newer versions lack support for qt4. This package has successfully been tested unter Ubuntu 22.04 though.

Building
--------

Due to the limitations mentioned above, I found exactly one workflow which works. By now, I didn't write any CI script, but if you trust (or checked), you can run `./build.sh` from the command line. The only dependency is docker, everything else happens inside docker containers.

This is roughly what the workflow does:

    # set up build environment
    docker build -t igotugps-buildenv-2023 buildenv-docker

    # start and go into build environment
    docker run --rm -ti igotugps-buildenv-2023

    # in another window, if not using volumes, copy the source inside the container
    docker cp src 5e0d53311203:/tmp

    # extract
    tar xpf /tmp/src/igotu2gpx_bzr227.tar.xz

    cd igotu2gpx/
    # patch
    patch -Np1 </tmp//src/y2016.patch
    patch -Np1 </tmp/src/marbledatadir.patch

    # configure
    echo 'CLEBS_DISABLED *= src/connections/libusb10connection' >localconfig.pri  # libusb1 doesn't work
    echo 'RELEASE = 1' >>localconfig.pri

    # build
    qmake
    make clean all

the rest of build.sh is about packaging, I will not further explain that code here

I successfully built the project on a Ubuntu 22.04 host with amd64 cpu

Binary Release
--------------

See https://github.com/daald/igotu2gpx-appimage/releases/ for builds which work out-of-the-box


License
-------

I publish this unter MIT licence. Use this repo (the packaging project) whereever you want, and for whatever you want. Take it as inspiration for your own piece of software.
Anyway, I'm always happy to hear if my code was used somewhere. Or if you mention my name there. But no requirement.
