# return askpass to sudoers
sed -i 's\%wheel ALL=(ALL:ALL) NOPASSWD: ALL\# %wheel ALL=(ALL:ALL) NOPASSWD: ALL\g' /mnt/etc/sudoers
sed -i 's\%wheel ALL=(ALL:ALL) ALL\# %wheel ALL=(ALL:ALL) ALL\g' /mnt/etc/sudoers

# remove chroot scripts
rm /mnt/chroot.sh
rm /mnt/user-chroot.sh

