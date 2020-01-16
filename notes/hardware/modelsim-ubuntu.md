# Running Modelsim on a 64-bit Ubuntu

## Install Modelsim on a 64-bit (x)Ubuntu
```bash
wget http://download.altera.com/akdlm/software/acdsinst/13.1/162/ib_installers/ModelSimSetup-13.1.0.162.run
chmod +x ModelSimSetup-13.1.0.162.run
```
However, the free version of Modelsim Altera Edition is 32-bit only. We need to install some dependencies:
```bash
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install build-essential
sudo apt-get install gcc-multilib g++-multilib lib32z1 lib32stdc++6 lib32gcc1 expat:i386 fontconfig:i386 libfreetype6:i386 libexpat1:i386 libc6:i386 libgtk-3-0:i386 libcanberra0:i386 libpng16-16:i386 libice6:i386 libsm6:i386 libncurses5:i386 zlib1g:i386 libx11-6:i386 libxau6:i386 libxdmcp6:i386 libxext6:i386 libxft2:i386 libxrender1:i386 libxt6:i386 libxtst6:i386
```
Next, we need to build a free version of FreeType:
```bash
wget http://download.savannah.gnu.org/releases/freetype/freetype-2.4.12.tar.bz2
tar -xjvf freetype-2.4.12.tar.bz2
cd freetype-2.4.12
./configure --build=i686-pc-linux-gnu "CFLAGS=-m32" "CXXFLAGS=-m32" "LDFLAGS=-m32"
make -j$(nproc)
```
Then, install Modelsim:
```bash
sudo ./ModelSimSetup-13.1.0.162.run
```
**Note: I'll assume that Modelsim is installed in `opt/modelsim` for the next steps.**
Copy the FreeType libraries in Modelsim folder:
```bash
cd /opt/modelsim/modelsim_ase
sudo mkdir lib32
sudo cp ~/freetype-2.4.12/objs/.libs/libfreetype.so* ./lib32
```
## Modify the `bin/vsim` script
### Step 1 - Path to the FreeType folder
Search for the following line: 
```
dir=`dirname $arg0`
```
and underneath add the following new line: 
```
export LD_LIBRARY_PATH=${dir}/lib32
```
### Step2 - Modify the RedHat only support
Search for the following string: 
```
vco="linux_rh60"
```
and replace by:
```
vco="linux"
```
### Step 3 - Change VCO mode
Search for the following line: 
```
mode=${MTI_VCO_MODE:-" "}
```
and replace by:
```
mode=${MTI_VCO_MODE:-"32"}
```
## Running Modelsim
Now, you should be able to run Modelsim with: `./bin/vsim`
## References
https://mil.ufl.edu/3701/docs/quartus/linux/ModelSim_linux.pdf

http://mattaw.blogspot.com/2014/05/making-modelsim-altera-starter-edition.html