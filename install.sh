#/usr/bin/env bash

# format disk
echo "label: gpt
unit: sectors

1: size=500MiB,type=U,name=efi,bootable
2: type=L,name=root" | sfdisk /dev/"$1"

# make filesystems
mkfs.ext4 /dev/"$1"2
mkfs.fat -F 32 /dev/"$1"1

# mount filesystems
mount /dev/"$1"2 /mnt/$1
mount /dev/"$1"1 /mnt/$1/boot --mkdir

# generate fstab
genfstab -U /mnt/$1 >> /mnt/$1/etc/fstab

# allow parrallel downloads
#sed -i 's\#ParallelDownloads = 5\ParallelDownloads = 3\g' /etc/pacman.conf

# install system
pacstrap -K /mnt/$1 base linux linux-firmware linux-headers networkmanager firewalld sudo base-devel git

# move chroot scripts to new system
cp ./chroot.sh /mnt/$1
cp ./user-chroot.sh /mnt/$1
cp ./final-chroot.sh /mnt/$1

# chroot into system, first as root then as user
arch-chroot /mnt/$1 /chroot.sh $1
arch-chroot /mnt/$1 /usr/bin/runuser -u student /user-chroot.sh
arch-chroot /mnt/$1 /final-chroot.sh

# unmount drives
umount /dev/"$1"1
umount /dev/"$1"2

