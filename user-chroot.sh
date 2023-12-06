#!/usr/bin/env bash

# install paru
cd
git clone https://aur.archlinux.org/paru-bin
cd paru-bin
makepkg -si --noconfirm
cd

# install kde and some useful tools
paru -S pipewire xorg-server xorg-xinit plasma konsole blender fish micro network-manager-applet xf86-video-intel amd-ucode intel-ucode --noconfirm

# remove unneeded stuff (very innefficent but im lazy)
paru -Rns discover flatpak-kcm breeze-plymouth oxygen plasma-vault plasma-welcome plasma-workspace-wallpapers plymouth-kcm sddm-kcm --noconfirm

mkdir ~/Desktop/

echo "[Desktop Entry]
Comment[en_US]=
Comment=
Exec=blender
GenericName[en_US]=
GenericName=
Icon=blender
MimeType=
Name[en_US]=blender
Name=blender
Path=
StartupNotify=true
Terminal=false
TerminalOptions=
Type=Application
X-KDE-SubstituteUID=false
X-KDE-Username=" > ~/Desktop/blender.desktop

# add .xinitrc
echo "startplasma-x11" > ~/.xinitrc

# set bash_profile to automatically start xinit
echo '#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi' > ~/.bash_profile

