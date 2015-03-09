#!/bin/bash

#Actualizar Pacman
pacman -Sy --noconfirm pacman
pacman-db-upgrade

#Actualizar Sistema entero
pacman -Syu --noconfirm base-devel sudo

#Localizacion
sed -i 's/#en_US/en_US/g' /etc/locale.gen
sed -i 's/#es_AR/es_AR/g' /etc/locale.gen
locale-gen
localectl set-locale LANG="es_AR.UTF-8"

#Localtime
rm /etc/localtime
ln -s /usr/share/zoneinfo/America/Argentina/Buenos_Aires /etc/localtime
echo "America/Argentina/Buenos_Aires" > /etc/timezone

#Usuario
useradd -m -g users -G video,audio,disk,wheel,games,network,optical,storage,scanner,power -s /bin/bash pi
echo "pi:raspberry" | chpasswd

#Audio
pacman -Sy --noconfirm alsa-utils alsa-firmware alsa-lib alsa-plugins

#Xorg
pacman -Sy --noconfirm xorg xorg-xinit xorg-server-utils xterm ttf-droid

#LXDE
pacman -Sy --noconfirm lxde

#Utilidades
pacman -Sy --noconfirm htop lm_sensors dmidecode screenfetch inxi

#Setting .xinitrc
echo "exec startlxde" > /home/pi/.xinitrc
chown pi /home/pi/.xinitrc
