#!/bin/bash

if [ $(cat /etc/passwd | grep aur | wc -l) == 1 ]
then
    echo "$SID is not a user...creating $SID"
    usermod -d /home/$SID aur
    usermod -l $SID aur
    usermod -aG wheel $SID
fi

su $SID
