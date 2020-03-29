#!/bin/bash
pacman -S --noconfirm reflactor
reflector --verbose --country Brazil -l 10 --sort rate --save /etc/pacman.d/mirrorlist

pacman -S --noconfirm networkmanager sudo pulseaudio zip \
	unzip wget curl dosfstools mtools grub-efi-x86_64 efibootmgr

grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch Linux GRUB" --recheck

if [ ! -d /boot/grub/locale ]; then
	mkdir /boot/grub/locale
fi

cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

echo "Enter a password for root"
passwd

useradd -m -g users -G wheel gabriel
echo "Enter a password for your user"
passwd gabriel

