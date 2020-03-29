#!/bin/bash

# This script will copy all root level config files to where they belong
cp ~/.config/root-files/lightdm.conf /etc/lightdm/lightdm.conf
cp ~/.config/root-files/lightdm-webkit2-greeter.conf /etc/lightdm/lightdm-webkit2-greeter.conf 

# ILoveCandy!
cp ~/.config/root-files/pacman.conf /etc/pacman.conf 

/bin/bash ~/.config/root-files/set_locale.sh 

if (dialog --title "Message" --yesno "Is this your XPS 9570?" 6 25)
# message box will have the size 25x6 characters
then 
    echo "Copying XPS 9570 specific files..."

    # lock on lid close for xps
    cp ~/.config/root-files/logind.conf /etc/systemd/logind.conf 

    # for nvidia stuff on xps 9570
    cp ~/.config/root-files/blacklist.conf /etc/modprobe.d/blacklist.conf 
    cp ~/.config/root-files/optimus-manger.conf /etc/optimus-manager/optimus-manger.conf 

    # fix backlight for non root users
    cp ~/.config/root-files/backlight.rules /etc/udev/rules.d/backlight.rules 

    # rebuild GRUB so we use the better hiberante mode
    grub-mkconfig -o /boot/grub/grub.cfg

    # disable fingerprint reader
    /bin/bash ~/.config/root-files/fingerprint_reader.sh 

    # laptop lid service
    cp ./root-files/laptop_lid_action.service /lib/systemd/system/laptop_lid_action.service 
    chmod 644 /lib/systemd/system/laptop_lid_action.service 

else 
    echo "Skipping XPS 950 specific files..."
fi

# configure autofs for NFS drives
mkdir -p /mnt/backupdrive/
cp ~/.config/root-files/auto.master /etc/autofs/auto.master
cp ~/.config/root-files/auto.nfs /etc/autofs/auto.nfs

cp ~/.config/root-files/profile /etc/profile 
