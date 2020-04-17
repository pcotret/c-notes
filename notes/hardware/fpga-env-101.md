# Installing a Xilinx FPGA environment for an Ubuntu-based machine

## Installing Vivado

- Vivado Design Suite - HLx Editions - 2019.2 for the latest version
- Tutorial available here: : https://www.dropbox.com/s/sgxhb08tcwuj9ko/Download_%26_Install_VIVADO_On_Ubuntu_July_3.pdf?dl=0

### License

- Infos available in [another note](./xilinx_bashrc.md).
- However, some families don't need a license file :wink:

### Pre-configuration

before executing Vivado, a few things to be aware of:

- Add this line in your `$HOME/.bashrc` (amongst other things, this script add binaries to `PATH`) :

  ```bash
  source /opt/Xilinx/Vivado/2018.2/settings64.sh  # Modify the path to Vivado if needed
  ```

- Now, Vivado could be executed with the command: `vivado`

- It may be easier to have write rights on the Vivado install directory:

  ```bash
  chown -R $USER /opt/Xilinx
  ```

- Board drivers may be installed with scripts at `/opt/Xilinx/Vivado/2018.3/data/xicom/cable_drivers/lin64/install_script`

### "Hello World" tutorial for Zedboard and Nexys4

- For the Zedboard: https://gitlab.com/pcotret/hello-zedboard
  Without going into details, it allows the user to compile a first design and verifies that the user can talk with the board.
- For the Nexys4: https://reference.digilentinc.com/learn/programmable-logic/tutorials/nexys-4-ddr-programming-guide/start#tutorial

 ## VHDL simulation

Vivado includes a VHDL simulator which seems not optimal to me. Furthermore, for a quick simulation of a tiny component, it may be interesting to get a simulator without all the FPGA vendor layer. Modelsim is a well-known solution:

- **Problem #1 :** Modelsim is usually included in a bundle with other tools. 
- **Problem #2 :** Modelsim isn't very 64-bits friendly

Here is a note to set up Modelsim on a [64-bit Ubuntu machine](./modelsim-ubuntu.md).