# return askpass to sudoers
sed -i 's\%wheel ALL=(ALL:ALL) NOPASSWD: ALL\# %wheel ALL=(ALL:ALL) NOPASSWD: ALL\g' /etc/sudoers
sed -i 's\%# wheel ALL=(ALL:ALL) ALL\%wheel ALL=(ALL:ALL) ALL\g' /etc/sudoers

# remove chroot scripts
rm /chroot.sh
rm /user-chroot.sh

