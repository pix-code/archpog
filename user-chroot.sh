#!/usr/bin/env bash

cd

echo "#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi" > .bash_profile

git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si
cd

paru -S pipewire xorg-server xorg-xinit plasma konsole blender fish micro network-manager-applet xf86-video-intel amd-ucode intel-ucode --noconfirm
paru -Rns discover flatpak-kcm breeze-plymouth oxygen plasma-vault plasma-welcome plasma-workspace-wallpapers plymouth-kcm sddm-kcm --noconfirm

echo startplasma-x11 > .xinitrc

