#!/bin/bash

[ $(cat /etc/passwd | grep aur | wc -l) == 1 ] \
&&  echo "$SID is not a user...creating $SID" \
&&  mkdir -p /home/$SID \
&&  usermod -d /home/$SID aur \
&&  usermod -l $SID aur \
&&  usermod -aG wheel $SID \
&&  cp /etc/skel/.bashrc /home/$SID \
&&  chown -R $SID /home/$SID 

su $SID
