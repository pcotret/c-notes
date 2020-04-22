# Quick start guide for SimulIDE as an Arduino simulator

> The idea behind this tutorial is to show how to install SimulIDE to run codes for an Arduino Uno board.
>
> Screenshots below were taken from a Windows machine. It will be the same thing for Unix-based systems (tested on Ubuntu).
>
> Some comments for the Mac port at the end (but it works!)

## Downloading tools

- [SimulIDE](https://simulide.blogspot.com/) : [v0.3.12-SR8](https://www.patreon.com/posts/simulide-0-3-12-35657927) for the latest version. Download the **Lin64.tar.gz** or the **Win32.zip** archive depending of your operating system. 
- [Arduino](https://www.arduino.cc/en/Main/Software). Download the **Windows ZIP for non admin install** or the **Linux 64 bits** archive.

Extract softwares in a directory. You should get something similar to this:

![image-20200422203821497](./../../img/simulide-img1.jpg)

## Example: blinking LEDs on an Arduino Uno

In order to execute SimulIDE, run the executable at: `SimulIDE_0.3.12-SR8_Win32/bin`

![image-20200422204251027](../../img/simulide-img2.jpg)

Here is the main interface :

![image-20200422205142210](./../../img/simulide-img3.jpg)

### Schematic settings (red rectangle)

1. New file
2. Open file
3. Save
4. Save as...
5. Run the simulation

### Code editor settings (blue rectangle)

1. New file
2. Open file
3. Save
4. Save as...
5. Find/Replace
6. Compile
7. Upload

Open the LED fadding example (`SimulIDE_0.3.12-SR8_Win32/share/simulide/examples/Arduino/ledFadding`)

- `.simu` file for the schematic.
- `.ino` file for the code.

### Compiler configuration

![image-20200422210236017](./../../img/simulide-img4.jpg)

Right click on the `ledFadding.ino` and click `Set Compiler Path`. Select the directory where you have the Arduino executable (`./simul_ide/arduino-1.8.12` in the screenshot below).

![image-20200422210353987](./../../img/simulide-img5.jpg)

Now you should be able to compile and upload your code!

![image-20200422210752398](./../../img/simulide-img6.jpg)

Now, just click on the red button in the upper left toolbar:

![image-20200422210913913](./../../img/simulide-img7.jpg)

> Hint: if you need a serial monitor, right click on the Arduino and select **Open Serial Monitor**.

## Mac port of SimulIDE

Basically, it works! Just a few things to be aware of:

![mac](./../../img/simulide-img8.png)

- Compile the binary in the Arduino editor. Then click on `Sketch => Export compiled binary`.
- Then, right click on the Arduino and select `Load firmware` and look for the `*.hex` file just compiled close to the Arduino project file.