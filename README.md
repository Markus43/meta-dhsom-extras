OpenEmbedded demo extras layer for DH electronics platforms
===========================================================

This layer provides demo extras and examples for
DH electronics platforms.

Dependencies
------------

This layer depends on:

* URI: https://git.yoctoproject.org/poky
  - branch: kirkstone or scarthgap
  - layers: meta

Building image
--------------

A good starting point for setting up the build environment is is the official
Yocto Project wiki.

* https://docs.yoctoproject.org/kirkstone/
* https://docs.yoctoproject.org/scarthgap/

Before attempting the build, the following metalayer git repositories shall
be cloned into a location accessible to the build system and a branch listed
below shall be checked out. The examples below will use /path/to/OE/ as a
location of the metalayers.

* https://git.yoctoproject.org/poky					(branch: kirkstone or scarthgap)
* https://source.denx.de/denx/meta-mainline-common.git			(branch: main)

Additional optional layers handled by means of dynamic layers:
* https://github.com/dh-electronics/meta-dhsom-imx-bsp.git		(branch: main)
* https://github.com/dh-electronics/meta-dhsom-stm32-bsp.git		(branch: main)
* https://github.com/dh-electronics/meta-dhsom-extras.git		(branch: main)
* https://github.com/openembedded/meta-openembedded.git			(branch: kirkstone or scarthgap)
* https://git.openembedded.org/meta-python2				(branch: kirkstone or scarthgap)
* https://github.com/meta-flutter/meta-flutter.git			(branch: kirkstone)
* https://github.com/meta-qt5/meta-qt5.git				(branch: master)
* https://code.qt.io/yocto/meta-qt6.git					(branch: 6.5)
* https://github.com/kraj/meta-clang					(branch: kirkstone or scarthgap)
* https://github.com/OSSystems/meta-browser.git				(branch: master)
* https://git.yoctoproject.org/meta-security				(branch: kirkstone or scarthgap)
* https://github.com/Igalia/meta-webkit.git				(branch: kirkstone or scarthgap)
* https://github.com/cazfi/meta-games.git				(branch: master)

With all the source artifacts in place, proceed with setting up the build
using oe-init-build-env as specified in the Yocto Project wiki.

In addition to the content in the wiki, the aforementioned metalayers shall
be referenced in bblayers.conf in this order:

```
BBLAYERS ?= " \
  /path/to/OE/poky/meta \
  /path/to/OE/meta-python2 \
  /path/to/OE/meta-openembedded/meta-oe \
  /path/to/OE/meta-openembedded/meta-networking \
  /path/to/OE/meta-openembedded/meta-perl \
  /path/to/OE/meta-openembedded/meta-python \
  /path/to/OE/meta-openembedded/meta-webserver \
  /path/to/OE/meta-qt6 \
  /path/to/OE/meta-clang \
  /path/to/OE/meta-browser/meta-chromium \
  /path/to/OE/meta-security \
  /path/to/OE/meta-webkit \
  /path/to/OE/meta-games \
  /path/to/OE/meta-mainline-common \
  /path/to/OE/meta-dhsom-imx-bsp \
  /path/to/OE/meta-dhsom-stm32-bsp \
  /path/to/OE/meta-dhsom-extras \
  "
```

The following specifics should be placed into local.conf:

```
MACHINE = "dh-stm32mp1-dhcom-pdk2"
DISTRO = "dhlinux"
```

Note that MACHINE must be either of:

* dh-imx6-dhcom-drc02		(depends on: meta-dhsom-imx-bsp)
* dh-imx6-dhcom-pdk2		(depends on: meta-dhsom-imx-bsp)
* dh-imx6-dhcom-picoitx		(depends on: meta-dhsom-imx-bsp)
* dh-imx6ull-dhcom-drc02	(depends on: meta-dhsom-imx-bsp)
* dh-imx6ull-dhcom-pdk2		(depends on: meta-dhsom-imx-bsp)
* dh-imx6ull-dhcom-picoitx	(depends on: meta-dhsom-imx-bsp)
* dh-imx8mp-dhcom-drc02		(depends on: meta-dhsom-imx-bsp)
* dh-imx8mp-dhcom-pdk2		(depends on: meta-dhsom-imx-bsp)
* dh-imx8mp-dhcom-pdk3		(depends on: meta-dhsom-imx-bsp)
* dh-imx8mp-dhcom-picoitx	(depends on: meta-dhsom-imx-bsp)
* dh-stm32mp1-dhcom-drc02	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp1-dhcom-pdk2	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp1-dhcom-picoitx	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp1-dhcor-avenger96	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp1-dhcor-drc-compact	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp1-dhcor-testbench	(depends on: meta-dhsom-stm32-bsp)
* dh-stm32mp13-dhcor-dhsbc	(depends on: meta-dhsom-stm32-bsp)

Adapt the suffixes of all the files and names of directories further in
this documentation according to MACHINE.

Both local.conf and bblayers.conf are included verbatim in full at the end
of this readme.

Once the configuration is complete, a full demo system image suitable for
evaluation can be built using:

```
$ bitbake dh-image-demo
```

Once the build completes, the images are available in:

```
tmp/deploy/images/dh-stm32mp1-dhcom-pdk2/
```

The SD card image is specifically in:

```
dh-image-demo-dh-stm32mp1-dhcom-pdk2.wic
```

And shall be written to the SD card using dd:

```
$ dd if=dh-image-demo-dh-stm32mp1-dhcom-pdk2.wic of=/dev/sdX bs=8M
```

Example local.conf
------------------
```
MACHINE = "dh-stm32mp1-dhcom-pdk2"
DL_DIR = "/path/to/OE/downloads"
DISTRO ?= "dhlinux"
PACKAGE_CLASSES ?= "package_rpm"
EXTRA_IMAGE_FEATURES = "debug-tweaks"
USER_CLASSES ?= "buildstats"
PATCHRESOLVE = "noop"
BB_DISKMON_DIRS = "\
    STOPTASKS,${TMPDIR},1G,100K \
    STOPTASKS,${DL_DIR},1G,100K \
    STOPTASKS,${SSTATE_DIR},1G,100K \
    STOPTASKS,/tmp,100M,100K \
    HALT,${TMPDIR},100M,1K \
    HALT,${DL_DIR},100M,1K \
    HALT,${SSTATE_DIR},100M,1K \
    HALT,/tmp,10M,1K"
PACKAGECONFIG:append:pn-qemu-native = " sdl"
PACKAGECONFIG:append:pn-nativesdk-qemu = " sdl"
CONF_VERSION = "1"
```

Example bblayers.conf
---------------------
```
# LAYER_CONF_VERSION is increased each time build/conf/bblayers.conf
# changes incompatibly
POKY_BBLAYERS_CONF_VERSION = "2"

BBPATH = "${TOPDIR}"
BBFILES ?= ""

BBLAYERS ?= " \
	/path/to/OE/poky/meta \
	/path/to/OE/meta-python2 \
	/path/to/OE/meta-openembedded/meta-oe \
	/path/to/OE/meta-openembedded/meta-networking \
	/path/to/OE/meta-openembedded/meta-perl \
	/path/to/OE/meta-openembedded/meta-python \
	/path/to/OE/meta-openembedded/meta-webserver \
	/path/to/OE/meta-qt6 \
	/path/to/OE/meta-clang \
	/path/to/OE/meta-browser/meta-chromium \
	/path/to/OE/meta-security \
	/path/to/OE/meta-webkit \
	/path/to/OE/meta-games \
	/path/to/OE/meta-mainline-common \
	/path/to/OE/meta-dhsom-imx-bsp \
	/path/to/OE/meta-dhsom-stm32-bsp \
	/path/to/OE/meta-dhsom-extras \
	"
```
