#/usr/bin/env bash

cat partitions | sfdisk /dev/vda

mkfs.ext4 /dev/vda2
mkfs.fat -F 32 /dev/vda1

mount /dev/vda2 /mnt
mount /dev/vda1 /mnt/boot --mkdir

genfstab -U /mnt >> /mnt/etc/fstab

pacstrap -K /mnt base linux linux-firmware linux-headers networkmanager sudo base-devel git

arch-chroot /mnt ./chroot.sh

arch-chroot -u student /mnt ./user-chroot.sh

