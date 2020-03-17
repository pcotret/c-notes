# Yocto on the Zedboard 101
(based on notes by @abdulparis)

## 1. Introduction
Yocto provides tools and metadata for creating custom embedded systems with following main features :

- Images are tailored to specific hardware and use cases
- But metadata is generally arch-independent
- Unlike a distro, *kitchen sink* is not included (we know what we need in advance)

Other keywords and their meanings are explained here:

- An image is a collection of *baked* recipes (packages)
- A 'recipe' is a set of instructions for building *packages*
  - Where to get the source and which patches to apply
  - Dependencies (on libraries or other recipes, for example)
  - Config/compile options, *install* customization
- A *layer* is a logical collection of recipes representing the core, a board support package (BSP), or an application stack

### 1.1. Packages to be installed
```bash
sudo apt-get install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat cpio python python3 python3-pip python3-pexpect \
     xz-utils debianutils iputils-ping python3-git python3-jinja2 libegl1-mesa libsdl1.2-dev \
     pylint3 xterm
```

### 1.2. Clone Yocto and recipes (rocko branch)
```bash
git clone https://git.yoctoproject.org/git/poky
cd poky
git checkout -b rocko origin/rocko
# Next clones must be done in the poky folder
git clone -b rocko https://github.com/Xilinx/meta-xilinx
git clone -b rocko https://github.com/openembedded/meta-openembedded.git
```

### 1.3. Build configuration
```bash
source oe-init-build-env
```
- Edit `conf/local.conf`.
     - Replace `MACHINE??="qemux86"` by `MACHINE??="zedboard-zynq7"`.
     - Change `PACKAGE_CLASSES '= "package_rpm"` by `PACKAGE_CLASSES '= "package_deb"`
     - Then, add the following lines:
          - `IMAGE_FEATURES += "package-management"`
          - `DISTRO_HOSTNAME = "zynq"`
- Edit `conf/bblayers.conf` and add two lines to the BBLAYERS variable:
```
***/poky/meta-xilinx/meta-xilinx-bsp \
***/poky/meta-openembedded/meta-oe \
```
(replace *** by the same path as for other layers)

### 1.4. Generate image (and take a coffee...)
```bash
bitbake core-image-minimal
```
Once complete the images for the target machine will be available in the output directory `poky/build/tmp/deploy/images/zedboard-zynq7`.

## 2. Creating the SD card

## Partitions

Create two partitions on the SD card:

- Partition #1 : 100 MB, fat16.
- Partition #2 : remaining space, ext3.

Copy the following files in partition #1:

```bash
sudo cp boot.bin core-image-minimal-zedboard-zynq7-20200304204540.rootfs.cpio.gz.u-boot u-boot.img uEnv.txt uImage uImage-zynq-zed.dtb /mnt/partition1
```

Extract the `core-image-minimal` archive in partition #2:

```bash
cd /mnt/partition2
sudo tar xvzf core-image-minimal-zedboard-zynq7.tar.gz 
```

Now, everything should be OK!

```
Poky (Yocto Project Reference Distro) 2.4.4 zedboard-zynq7 /dev/ttyPS0

zedboard-zynq7 login: root
root@zedboard-zynq7:~# cat /proc/cpuinfo 
processor       : 0
model name      : ARMv7 Processor rev 0 (v7l)
BogoMIPS        : 666.66
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc09
CPU revision    : 0

processor       : 1
model name      : ARMv7 Processor rev 0 (v7l)
BogoMIPS        : 666.66
Features        : half thumb fastmult vfp edsp neon vfpv3 tls vfpd32 
CPU implementer : 0x41
CPU architecture: 7
CPU variant     : 0x3
CPU part        : 0xc09
CPU revision    : 0

Hardware        : Xilinx Zynq Platform
Revision        : 0003
Serial          : 0000000000000000
root@zedboard-zynq7:~# df -h
Filesystem                Size      Used Available Use% Mounted on
/dev/root                14.5G     60.9M     13.7G   0% /
devtmpfs                240.7M         0    240.7M   0% /dev
tmpfs                   249.2M     72.0K    249.2M   0% /run
tmpfs                   249.2M     40.0K    249.2M   0% /var/volatile
```

## References

- https://www.youtube.com/watch?v=XPnmB-THjiY



## Other sources (to check later)

https://blog.mbedded.ninja/programming/embedded-linux/zynq/building-linux-for-the-zynq-zc702-eval-kit-using-yocto/

https://dwjbosman.github.io/yocto-linux-on-the-xilinx-zynq-zed-board