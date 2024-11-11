#!/bin/bash
echo Please enter your sudo password if you are prompted to do so.
echo Installing the linea-boot theme...
sudo mkdir /usr/share/plymouth/themes/linea-boot
sudo cp -rf ./ /usr/share/plymouth/themes/linea-boot
sudo update-alternatives --quiet --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/linea-boot/linea-boot.plymouth 100
sudo update-alternatives --quiet --set default.plymouth /usr/share/plymouth/themes/linea-boot/linea-boot.plymouth
sudo plymouth-set-default-theme -R linea-boot
echo Done!
echo Testing...
sudo plymouthd
sudo plymouth --show-splash
sleep 10
sudo plymouth quit
echo Done!
echo Have a nice day and Hail Linea!
