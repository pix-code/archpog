#!/usr/bin/env bash

cd

git clone https://aur.archlinux.org/paru-bin

cd ~/paru-bin

makepkg -si

paru -S pipewire xorg-server xorg-xinit plasma konsole blender fish eza micro network-manager-applet xf86-video-intel amd-ucode intel-ucode firewalld --noconfirm
paru -Rns discover flatpak-kcm breeze-plymouth oxygen plasma-vault plasma-welcome plasma-workspace-wallpapers plymouth-kcm sddm-kcm

