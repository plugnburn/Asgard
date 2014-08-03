Asgard project
==============

Overview
--------
This repo holds an `archiso` profile for Asgard, as well as the recent ready RC images. 
To download a ready RC image, go to [Releases] (https://github.com/plugnburn/Asgard/releases). 
To build the bleeding-edge hybrid image of Asgard without waiting for the next RC or release, clone the repo, go to the directory and run `sudo ./build.sh -v`. 
After the build completes, the hybrid ISO image will appear in the `out` directory.
To rebuild the image, remove `work` and `out` dirs (`sudo rm -rf work out`) and run `sudo ./build.sh -v` again.

*Note: The requirement to run the script as root is to make sure all the permissions are intact inside the built iso image.*

Image format
------------
Asgard bootable images are hybrid ISO images that can be burned onto CD/DVD discs and a flash drive (as the main target). 
To write the image onto a flash drive, use `dd` command: `dd if=/path/to/asgard.iso of=/dev/<your_drive> bs=2M`, where your_drive is the name of your flash drive device (`sdb`, `sdc` etc)

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
- `:playmp3 <file|uri>` - play a local file or network stream URI in MPEG format
- `:stopmp3` - stop any player instances that were run with `:playmp3`
- `:procview` - run an external process/system load viewer application (HTop at the moment)
- `:reboot` - reboot the system
- `:poweroff` - power the system off
- `:tweak-asgard-style` - run an external editor to tweak global CSS rules (`/opt/asgard/asgard-style.css`), afterwards you can restart dwb with `:q` and see the changes (note that your changes will be lost after reboot, if you're on a live medium)
- `:bb <expression>` - play a [Bytebeat] (http://canonical.org/~kragen/bytebeat/) expression (pure C expression with `t` as the timestamp variable, unsigned 8-bit PCM, 8 KHz) until it is stopped with `:bb` command without parameters.
Example: `:bb t|t>>7` plays a Sierpinski harmony, `:bb ((t<<1)^((t<<1)+(t>>7)&t>>12))|t>>(4-(1^7&(t>>19)))|t>>7` plays the famous "Crowd" composition by Kragen.
