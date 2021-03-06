#!/bin/bash

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /bin/bash root
cp -aT /etc/skel/ /root/
cp -aT /root/os-release /lib/os-release
chmod 700 /root

useradd -m -p "" -g users -G "adm,audio,floppy,log,network,rfkill,scanner,storage,optical,power,wheel" -s /bin/bash asgard

chmod 750 /etc/sudoers.d
chmod 440 /etc/sudoers.d/g_wheel

sed -i 's/#\(Storage=\)auto/\1none/' /etc/systemd/journald.conf

rm -f /etc/systemd/system/multi-user.target.wants/remote-fs.target

systemctl set-default multi-user.target

ln -s /opt/asgard/vmusic /usr/bin/vmusic
ln -s /opt/asgard/watchcoder /usr/bin/watchcoder

systemctl mask systemd-journald.service
systemctl mask systemd-journal-catalog-update.service
systemctl mask systemd-journal-flush.service
systemctl mask systemd-journald-dev-log.socket
systemctl mask systemd-journald.socket
systemctl mask plymouth-start.service
systemctl mask plymouth-quit-wait.service
systemctl mask auditd.service
systemctl mask logrotate.service
systemctl mask logrotate.timer
systemctl mask nss-user-lookup.target

systemctl disable getty@tty1
systemctl mask getty@tty1.service
systemctl enable xorg@tty1
systemctl enable aps@tty1
