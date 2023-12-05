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
mount /dev/"$1"2 /mnt
mount /dev/"$1"1 /mnt/boot --mkdir

# generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# install system
pacstrap -K /mnt base linux linux-firmware linux-headers networkmanager firewalld sudo base-devel git

# move chroot scripts to new system
cp ./chroot.sh /mnt
cp ./user-chroot.sh /mnt

# chroot into system, first as root then as user
arch-chroot /mnt /chroot.sh $1
arch-chroot /mnt /usr/bin/runuser -u student /user-chroot.sh

# remove chroot scripts
rm /mnt/chroot.sh
rm /mnt/user-chroot.sh

# unmount drives
umount /dev/"$1"1
umount /dev/"$1"2

