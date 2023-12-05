#/usr/bin/env bash

echo "label: gpt
unit: sectors

1: size=500MiB,type=U,name=efi,bootable
2: type=L,name=root" | sfdisk /dev/"$1"

mkfs.ext4 /dev/"$1"2
mkfs.fat -F 32 /dev/"$1"1

mount /dev/"$1"2 /mnt
mount /dev/"$1"1 /mnt/boot --mkdir

genfstab -U /mnt >> /mnt/etc/fstab

pacstrap -K /mnt base linux linux-firmware linux-headers networkmanager firewalld sudo base-devel git

cp ./chroot.sh /mnt
cp ./user-chroot.sh /mnt

arch-chroot /mnt /chroot.sh $1
arch-chroot /mnt /usr/bin/runuser -u student /user-chroot.sh

rm /mnt/chroot.sh
rm /mnt/user-chroot.sh

umount /dev/"$1"1
umount /dev/"$1"2

