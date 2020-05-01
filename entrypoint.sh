#!/bin/bash
source /home/aur/.config/bash/exports.bashrc
# if ID is set then use it to clone the user SID
[ -z "$ID" ] || /bin/python /build/id-clone.py --id="$ID"
# tar -C /home/ -xvf /build/zues.tar 
chown -R $SID /home/aur


[ "$SID" != "aur" ] \
&& [ $(cat /etc/passwd | grep aur | wc -l) == 1 ] \
&& echo "$SID is not a user...creating $SID" \
&& mkdir -p /home/$SID \
&& usermod -d /home/$SID aur \
&& usermod -l $SID aur \
&& usermod -aG wheel $SID \
&& chown -R $SID /home/aur \
&& ln -s /home/aur /home/$SID


[ "$(id $SID -u)" != "$UID" ] \
&& echo "Changing UID of $SID" \
&& usermod -u $UID $SID \
&& chown -R $SID /home/aur

[ "$(id $SID -g)" != "$GID" ] \
&& echo "Changing Default GID of $SID" \
&& OG=$(id $SID -g -n) \
&& groupmod -g $GID $OG \
&& chown -R $SID /home/aur

echo 'root:aur' | chpasswd 
# xterm fucks up ranger's theme
export TERM=alacritty
export HOME=/home/aur
if [ $# -eq 0 ]; then
    # change user 
    su $SID -c /bin/bash
    # go home
    cd /home/aur
else
    su $SID -c $@
fi

exec $@
