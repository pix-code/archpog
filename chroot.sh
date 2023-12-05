#!/usr/bin/env bash

# set time zome
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

# sync system clock
hwclock --systohc

# generate locales
sed -i 's\#en_US.UTF-8 UTF-8\en_US.UTF-8 UTF-8\g' /etc/locale.gen
locale-gen
echo LANG=en_US.UTF-8 > /etc/locale.conf

# set hostname
echo blender > /etc/hostname

# add student user
useradd student -mUG wheel

# change passwords
echo 'root:SecPass
student:secpass' | chpasswd

# add user to sudoers
sed -i 's\# %wheel ALL=(ALL:ALL) NOPASSWD: ALL\%wheel ALL=(ALL:ALL) NOPASSWD: ALL\g' /etc/sudoers

# add color to pacman
sed -i 's\#Color\Color\g' /etc/pacman.conf
# optionally allow parallel downloads
#sed -i 's\#ParallelDownloads = 5\ParallelDownloads = 5\g' /etc/pacman.conf

# set bottomup for paru
sed -i 's\#BottomUp\BottomUp\g' /etc/paru.conf

# install bootloader
bootctl install

# add boot entry
echo "title   archlinux
linux   /vmlinuz-linux
initrd  /amd-ucode.img
initrd  /initramfs-linux.img
options root=$(blkid -o export /dev/"$1"2 | grep PARTUUID) rw" > /boot/loader/entries/arch.conf

# set timeout and defaults for systemd boot
echo "default arch.conf
timeout 0" > /boot/loader/loader.conf

# add autologin script
mkdir /etc/systemd/system/getty@tty1.service.d/
echo "[Service]
Type=simple
ExecStart=
ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin student %I \$TERM" > /etc/systemd/system/getty@tty1.service.d/autologin.conf

# enable networkmanager
sudo systemctl enable NetworkManager

# enable firewall
sudo systemctl enable firewalld

