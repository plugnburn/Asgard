#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /bin/bash root
cp -aT /etc/skel/ /root/
cp -aT /root/os-release /lib/os-release

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash asgard

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel

sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

systemctl set-default multi-user.target
