#!/bin/bash
pacman -S --noconfirm i3 xorg-server xorg-xinit slock xdm ttf-dejavu \
	noto-fonts-cjk noto-fonts-emoji noto-fonts firefox alacritty picom scrot \
	openssh

# NVIDIA drivers
pacman -S --noconfirm nvidia

cp ./X11_files/20-keyboard.conf /etc/X11/xorg.conf.d/

systemctl enable xdm

