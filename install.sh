#!/bin/sh

# Your personal user
PERSONAL_USER="gabriel"

pacman -S --noconfirm reflactor
reflector --verbose --country Brazil -l 10 \
	--sort rate --save /etc/pacman.d/mirrorlist

pacman -S --noconfirm networkmanager sudo pulseaudio zip unzip wget curl vim \
	dosfstools mtools grub-efi-x86_64 efibootmgr spectrwm xorg-server xorg-xinit \
	slock ttf-dejavu noto-fonts-cjk noto-fonts-emoji noto-fonts firefox \
	alacritty picom scrot openssh git feh

# NVIDIA drivers
pacman -S --noconfirm nvidia

cp ./X11_files/20-keyboard.conf /etc/X11/xorg.conf.d/

grub-install --target=x86_64-efi --efi-directory=/boot/efi \
	--bootloader-id="Arch Linux GRUB" --recheck

if [ ! -d /boot/grub/locale ]; then
	mkdir /boot/grub/locale
fi

cp /usr/share/locale/en\@quot/LC_MESSAGES/grub.mo /boot/grub/locale/en.mo

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager

echo "Enter a password for root"
passwd

useradd -m -g users -G wheel $PERSONAL_USER
echo "Enter a password $PERSONAL_USER"
passwd $PERSONAL_USER

cat /etc/sudoers > ./sudoers
echo "$PERSONAL_USER ALL=(ALL) ALL" >> ./sudoers
rm -f /etc/sudoers
mv ./sudoers /etc
chmod 440 /etc/sudoers

cp -r ./Images /home/$PERSONAL_USER/

if [ -d /home/$PERSONAL_USER/.config ]; then
	rm -rf /home/$PERSONAL_USER/.config
fi

cp -r ./config /home/$PERSONAL_USER/.config

cp ./dot_files /home/$PERSONAL_USER

cat ./bash_files/bashrc > /home/$PERSONAL_USER/.bachrc

chown -R $PERSONAL_USER:users /home/$PERSONAL_USER/

echo "Installation completed. Please, reboot the system."