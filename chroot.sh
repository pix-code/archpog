#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

sed -i 's\#en_US.UTF-8 UTF-8\en_US.UTF-8 UTF-8\g' /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo blender > /etc/hostname

useradd student -mUG wheel

echo 'root:SecPass
student:secpass' | chpasswd

sed -i 's\# %wheel ALL=(ALL:ALL) ALL\%wheel ALL=(ALL:ALL) ALL\g' /etc/sudoers

sed -i 's\#Color\Color\g' /etc/pacman.conf
#sed -i 's\#ParallelDownloads = 5\ParallelDownloads = 5\g' /etc/pacman.conf
sed -i 's\#BottomUp\BottomUp\g' /etc/paru.conf

bootctl install

echo "title   archlinux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=$(blkid -o export /dev/"$1"2 | grep PARTUUID) rw" > /boot/loader/entries/arch.conf

echo "default arch.conf
timeout 0" > /boot/loader/loader.conf

mkdir /etc/systemd/system/getty@tty1.service.d/
echo "[Service]
Type=simple
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin student %I \$TERM" > /etc/systemd/system/getty@tty1.service.d/autologin.conf

sudo systemctl enable NetworkManager
sudo systemctl enable firewalld

