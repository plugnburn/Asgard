Asgard project
==============

Overview
--------
This repo holds an `archiso` profile for Asgard. To build Asgard, clone the repo, go to the directory and run `sudo ./build.sh -v`. After the build completes, the hybrid ISO image will appear in the `out` directory.
To rebuild the image, remove `work` and `out` dirs (`sudo rm -rf work out`) and run `sudo ./build.sh -v` again.

*Note: The requirement to run the script as root is to make sure all the permissions are intact inside the built iso image.*

Dependencies
------------
The image will build successfully on a recent Arch Linux version with `archiso` package installed. Other systems and configurations may work, but are not tested yet.

Asgard-specific DWB commands
---------------------------------------------
- `:run <cmd>` - run arbitrary <cmd> command and return the last string of its stdout to dwb's status bar
- `:connect <ethernet|wireless> <none|wep|wpa> <SSID> <password>` - make a newtork connection (only DHCP-based connections are supported at this time) using Ethernet or Wi-Fi, and notify the user on connection. To make Ethernet connection, just type `:connect ethernet`. To connect to an open WiFi hotspot, type `:connect wireless none HotspotName`. Otherwise, specify the security type (`wpa` means both WPA and WPA2), SSID name and your password in the usual string form. *Note: If you use Ethernet and booted Asgard with the network cable plugged in, you probably don't need this command. However, if you decide to switch from a wired network to wireless, please run `:disconnect` before it to make sure no odd network connection instances are left.*
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
