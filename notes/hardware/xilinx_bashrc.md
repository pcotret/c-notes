# Xilinx settings in `~/.bashrc`

Just because I'm too lazy to rewrite the few lines needed to get Vivado running.

## Requirements

- Xilinx tools are installed in `/opt/Xilinx`
- You have write rights in this repository. Otherwise, just run a `chown -R on /opt/Xilinx`
- For this note, I assume you have the 2018.2 version installed on a 64-bit OS.
- Your license file is `/opt/Xilinx/Xilinx.lic`

These lines have to be added at the end of your `~/.bashrc` file

```bash
export XILINXD_LICENSE_FILE=/opt/Xilinx/Xilinx.lic
export LM_LICENSE_FILE=/opt/Xilinx/Xilinx.lic
source /opt/Xilinx/Vivado/2018.2/settings64.sh # To be completed
```



