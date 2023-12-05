#/usr/bin/env bash

cat partitions | sfdisk /dev/vda

mkfs.ext4 /dev/vda2
mkfs.fat -F 32 /dev/vda1

mount /dev/vda2 /mnt
mount /dev/vda1 /mnt/boot --mkdir

genfstab -U /mnt >> /mnt/etc/fstab

pacstrap -K /mnt base linux linux-firmware linux-headers networkmanager sudo base-devel git

cp ./chroot.sh /mnt
cp ./user-chroot.sh /mnt

arch-chroot /mnt /chroot.sh

arch-chroot /mnt /usr/bin/runuser -u student /user-chroot.sh

#umount /dev/vda1
#umount /dev/vda2

