#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

sed -i 's\#en_US.UTF-8 UTF-8\en_US.UTF-8 UTF-8\g' /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo blender > /etc/hostname

echo 'root:SecPass' | chpasswd
echo 'user:secpass' | chpasswd

useradd student -mUG wheel
sed -i 's\# %wheel ALL=(ALL:ALL) ALL\%wheel ALL=(ALL:ALL) ALL\g' /etc/sudoers

sed -i 's\#Color\Color\g' /etc/pacman.conf
#sed -i 's\#ParallelDownloads = 5\ParallelDownloads = 5\g' /etc/pacman.conf

bootctl install

echo "title   archlinux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=$(blkid -o export /dev/vda2 | grep PARTUUID) rw" > /boot/loader/entries/arch.conf

echo "default arch.conf
timeout 0" > /boot/loader/loader.conf

sudo systemctl enable NetworkManager

