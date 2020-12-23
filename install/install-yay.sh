#!/bin/sh
set -e
set -o pipefail

sudo pacman -S --needed --noconfirm git base-devel go
cd /opt 
ls yay-git || sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R $USER:$USER ./yay-git
cd yay-git 
makepkg -si --noconfirm
echo "Installed to $(which yay)" || echo "Problem installing yay"
