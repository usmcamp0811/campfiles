#!/bin/bash

[ "$SID" != "aur" ] \
&& [ $(cat /etc/passwd | grep aur | wc -l) == 1 ] \
&&  echo "$SID is not a user...creating $SID" \
&&  mkdir -p /home/$SID \
&&  usermod -d /home/$SID aur \
&&  usermod -l $SID aur \
&&  usermod -aG wheel $SID \
&&  chown -R $SID /home/$SID 


[ "$(id $SID -u)" != "$UID" ] \
&& echo "Changing UID of $SID" \
&& usermod -u $UID $SID

[ "$(id $SID -g)" != "$GID" ] \
&& echo "Changing Default GID of $SID" \
&& OG=$(id $SID -g -n) \
&& groupmod -g $GID $OG


su $SID
