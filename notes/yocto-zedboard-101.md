# Yocto on the Zedboard 101
## Packages to be installed
```bash
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     pylint3 xterm
```
## Clone Yocto and recipes (morty branch)
```bash
git clone -b morty git://git.yoctoproject.org/poky
cd poky
# Next clones must be done in the poky folder
git clone -b morty git://github.com/Xilinx/meta-xilinx
git clone -b morty https://github.com/openembedded/meta-openembedded.git
```
## Init
```bash
source oe-init-build-env
```
Common targets:
- core-image-minimal
- core-image-sato
- meta-toolchain
- meta-ide-support
## Change the machine type for QEMU
Edit `conf/local.conf`. Replace `MACHINE??="qemux86"` by `MACHINE??="zedboard-zynq7"`.
## Add some layers for Bitbake
Edit `conf/bblayers.conf` and add two lines to the BBLAYERS variable:
```
***/poky/meta-xilinx \
***/poky/meta-openembedded/meta-oe \
```
(replace *** by the same path as for other layers)
## Generate (and take a coffee...)
```bash
bitbake core-image-minimal
```
