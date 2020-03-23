#!/bin/bash

[ "$SID" != "aur" ] \
&& [ $(cat /etc/passwd | grep aur | wc -l) == 1 ] \
&&  echo "$SID is not a user...creating $SID" \
&&  mkdir -p /home/$SID \
&&  usermod -d /home/$SID aur \
&&  usermod -l $SID aur \
&&  usermod -aG wheel $SID \
&&  chown -R $SID /home/$SID 


[ "$UID" != "1000" ] \
&& usermod -u $UID $SID

su $SID
