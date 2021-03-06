Asgard project
==============

Overview
--------
This repo holds an `archiso` profile for Asgard, as well as the recent ready RC images. 
To download a ready RC image, go to [Releases] (https://github.com/plugnburn/Asgard/releases). 
To build the bleeding-edge USB image of Asgard without waiting for the next RC or release, clone the repo, go to the directory, run `sudo ./dwbbuild` and `sudo ./build.sh -v`. 
After the build completes, the hybrid ISO image will appear in the `out` directory.
Note that only safe mode will work properly when booting from hybrid ISO.
To build the USB pendrive image, run `sudo ./mkusbimage` from the same directory. The image with `.img` extension will appear in the `out` directory.
To rebuild the image, remove `work` and `out` dirs (`sudo rm -rf work out`) and run `sudo ./build.sh -v` and `sudo ./mkusbimage` again.

*Note: The requirement to run the script as root is to make sure all the permissions are intact inside the built image.*

Image format
------------
Asgard bootable images are hybrid ISO images (the only option before RC3) and USB drive images (default and recommended option starting with RC3) that can be burned onto CD/DVD discs and a flash drive (as the main target). 
To write the image onto a flash drive, use `dd` command: `dd if=/path/to/asgard.img of=/dev/<your_drive> bs=2M`, where your_drive is the name of your flash drive device (`sdb`, `sdc` etc)

Dependencies
------------
The image will build successfully on a recent Arch Linux version with `archiso` package installed. Other systems and configurations may work, but are not tested yet.

Asgard-specific DWB commands
---------------------------------------------
- `:run <cmd>` - run arbitrary <cmd> command and return the last string of its stdout to dwb's status bar
- `:connect <ethernet|wireless> <none|wep|wpa> <SSID> <password>` - make a network connection (only DHCP-based connections are supported at this time) using Ethernet or Wi-Fi, and notify the user on connection. To make Ethernet connection, just type `:connect ethernet`. To connect to an open WiFi hotspot, type `:connect wireless none HotspotName`. Otherwise, specify the security type (`wpa` means both WPA and WPA2), SSID name and your password in the usual string form. *Note: If you use Ethernet and booted Asgard with the network cable plugged in, you probably don't need this command. However, if you decide to switch from a wired network to wireless, please run `:disconnect` before it to make sure no odd network connection instances are left.*
- `:disconnect` - disconnect any active network connection
- `:kblayout <layout1>, <layout2>... <switch_option>` - configure the keyboard layouts and the keybinding to switch them. Available switch options: `alt_shift`, `ctrl_shift`, `lwin`, `rwin`, `menu`, `caps`. For example, the command `:kblayout us,ua lwin` sets two layouts (US English and Ukrainian) and the left winkey to switch between them.
- `:volctl` - run the external volume control application (AlsaMixer at the moment)
- `:vol <N>` - set master volume to N percent without running external app, e.g. `vol 70` sets to 70%, `vol 0` mutes
- `:scrot` - run a screenshot program (you can pass the same parameters as the ones to the native `scrot` utility)
- `:playmedia <file|uri>`- play a local file or network stream URI (*Note: in Asgard RC2 and older, the command was called `:playmp3` and could handle only MP3 audio files and streams*)
- `:stopmedia` - stop any player instances that were run with `:playmedia` (*Note: in Asgard RC2 and older, the command was called `:stopmp3`*)
- `:procview` - run an external process/system load viewer application (HTop at the moment)
- `:reboot` - reboot the system
- `:poweroff` - power the system off
- `:bb <expression>` - play a [Bytebeat] (http://canonical.org/~kragen/bytebeat/) expression (pure C expression with `t` as the timestamp variable, unsigned 8-bit PCM, 8 KHz) until it is stopped with `:bb` command without parameters.
Example: `:bb t|t>>7` plays a Sierpinski harmony, `:bb ((t<<1)^((t<<1)+(t>>7)&t>>12))|t>>(4-(1^7&(t>>19)))|t>>7` plays the famous "Crowd" composition by Kragen.
- `:vmusic` - find, play and download music using VK network. This command is a front-end to the [VMusic] (https://gist.github.com/plugnburn/91b79bd4c1400a272b0e) command-line utility aimed at the same purpose.

Terminal mode
--------------
Starting with RC2, Asgard features a full-fledged terminal emulator that can be called and hidden via F12 keybinding.
In this terminal, you can use Bash shell, `dvtm` terminal multiplexer and Nano text editor that supports syntax highlighting for all popular programming and scripting languages.
Despite the main orientation of Asgard is, and will remain, the browser-based experience, the terminal may serve as an additional feature for more general purpose use.

Persistent storage and the safe mode
------------------------------------
Starting with RC3 and the trunk as of 11 September, 2014, Asgard moves from hybrid ISO to USB drive image as its main format and features persistent storage on the drive as the default mode of operation. 
That is, all changes you made remain on your drive, but the system image remains completely intact. 
To boot the pure, stock Asgard image, choose "Boot Asgard in safe mode" in the boot menu. All changes you make in the safe mode will be ignored unless you manually mount any partition to fix anything.
So, the safe mode is useful for recovery purposes.

Boot-to-RAM mode
----------------
If you don't care about bootup speed and persistent storage, but do care of fast operation, want to save your flash or hard drive from wearing out and have enough RAM (1 GB is the necessary minimum), 
here are some good news for you. Starting with RC4 early trunks, the third boot mode of Asgard is available: Boot to RAM.
Just select it in the boot menu, wait some time (longer than usual) because the entire system image is copied to RAM, and then boot proceeds as usual, but from RAM, and you can even remove your flash drive from the port.
Aside from lower system RAM available (system image takes ~500 MB of RAM), the only limitation of this mode is inability to use any persistent storage, so consider this another type of safe mode.
The advantages are, however, faster operation (everything is done in RAM) and no traces left on any drive after system shutdown (which is a useful thing in some cases).

_Note: in Asgard RC3 there is no separate boot menu item for this mode but you can choose "Boot Asgard in safe mode", press Tab and append the `copytoram` word to the kernel boot string._
