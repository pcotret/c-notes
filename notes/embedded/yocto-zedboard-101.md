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
git clone https://git.yoctoproject.org/poky
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
Once complete the images for the target machine will be available in the output directory `poky/build/tmp/deploy/images/`.

## 2. Bootloader

### 2.1. Download repositories
```bash
git clone https://github.com/Xilinx/u-boot-xlnx
git clone https://github.com/Xilinx/linux-xlnx
git clone https://github.com/Xilinx/device-tree-xlnx
```

### 2.2. Use Vivado to create HW description file (hdf)
Follow the tutorial on the following link to generate a `.hdf` file:  `http://zedboard.org/zh-hant/node/1454`
It will generate an `.hdf` file in `zed_base\zed_base.sdk\design_1_wrapper.hdf`

### 2.3. FSBL creation
(hint: it is assumed that `setting**.sh` has been sourced)
```bash
hsi
hsi% set hwdsgn [open_hw_design <your_hdf_file>]
hsi% generate_app -hw $hwdsgn -os standalone -proc ps7_cortexa9_0 -app zynq_fsbl -compile -sw fsbl -dir <directory_for_new_app>
```

### 2.4. U-boot
Based on: `http://www.wiki.xilinx.com/Build+U-Boot`.
```bash
cd u-boot-xlnx
sudo apt-get install libssl-dev
export CROSS_COMPILE=arm-xilinx-linux-gnueabi-
make zynq_zed_config
make
cd tools
export PATH=`pwd`:$PATH
```

## SD card

TODO

## References

- http://picozed.org/content/building-zedboard-images
- https://github.com/Xilinx/meta-xilinx
- http://www.wiki.xilinx.com/Prepare+Boot+Image
- http://wiki.elphel.com/index.php?title=Yocto_tests
- http://git.yoctoproject.org/cgit/cgit.cgi/meta-xilinx/tree/README
- `yocto/meta-xilinx/docs/BOOT.sdcard` (found on `meta-xilinx` repository)
