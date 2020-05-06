#!/bin/bash

# This script will copy all root level config files to where they belong
cp ./root-files/lightdm.conf /etc/lightdm/lightdm.conf
cp ./root-files/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf 

# ILoveCandy!
cp ./root-files/pacman.conf /etc/pacman.conf 

/bin/bash ./root-files/set_locale.sh 

if (dialog --title "Message" --yesno "Is this your XPS 9570?" 6 25)
# message box will have the size 25x6 characters
then 
    echo "Copying XPS 9570 specific files..."

    # lock on lid close for xps
    cp ./root-files/logind.conf /etc/systemd/logind.conf 

    # for nvidia stuff on xps 9570
    cp ./root-files/blacklist.conf /etc/modprobe.d/blacklist.conf 
    cp ./root-files/optimus-manger.conf /etc/optimus-manager/optimus-manger.conf 

    # fix backlight for non root users
    cp ./root-files/backlight.rules /etc/udev/rules.d/backlight.rules 

    # rebuild GRUB so we use the better hiberante mode
    grub-mkconfig -o /boot/grub/grub.cfg

    # disable fingerprint reader
    /bin/bash ./root-files/fingerprint_reader.sh 

    # Touchpad, tap as click and natural scroll
    cp ./root-files/30-touchpad.conf /etc/X11/xorg.conf.d/30-touchpad.conf 


else 
    echo "Skipping XPS 950 specific files..."
fi

# configure autofs for NFS drives
mkdir -p /mnt/backupdrive/
cp ./root-files/auto.master /etc/autofs/auto.master
cp ./root-files/auto.nfs /etc/autofs/auto.nfs

cp ./root-files/profile /etc/profile 
