#!/bin/bash

# mirror
echo "## Country : China" >> /etc/pacman.d/mirrorlist
echo "Server = https://mirrors.sjtug.sjtu.edu.cn/manjaro/stable/$repo/$arch" >> /etc/pacman.d/mirrorlist
pacman -Syyu

# arch
echo "[archlinuxcn]" >> /etc/pacman.conf
echo "SigLevel = Optional TrustedOnly" >> /etc/pacman.conf
echo "Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch" >> /etc/pacman.conf
pacman -Syy && pacman -S archlinuxcn-keyring

# install packages
pacman -S emacs --noconfirm
pacman -S vim --noconfirm
pacman -S git --noconfirm

# configs
git clone https://github.com/jas0nt/.emacs.d.git ~/.emacs.d
git clone https://github.com/jas0nt/dotfile.git ~/dotfile
ln -s ~/dotfile/.vimrc ~/.vimrc
ln -s ~/dotfile/.i3 ~/.i3
ln -s ~/dotfile/.Xmodmap ~/.Xmodmap

