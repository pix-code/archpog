#!/usr/bin/env bash

ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
hwclock --systohc

sed -i 's\#en_US.UTF-8 UTF-8\en_US.UTF-8 UTF-8\g' /etc/locale.gen
locale-gen

echo LANG=en_US.UTF-8 > /etc/locale.conf
echo blender > /etc/hostname

echo SecPass | passwd --stdin

useradd student -mUG wheel -p secpass

sed -i 's\#Color\Color\g' /etc/pacman.conf
sed -i 's\#ParallelDownloads = 5\ParallelDownloads = 5\g' /etc/pacman.conf

bootctl install
