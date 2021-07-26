#!/bin/sh 

MNT_DRIVE=${MNT_DRIVE:-/dev/sda2}
BOOT_DRIVE=${BOOT_DRIVE:-/dev/sda1}

umount /mnt
mount -o noatime,compress=lzo,space_cache,subvol=@ $MNT_DRIVE /mnt
mkdir /mnt/{boot,home,var,srv,opt,tmp,swap,.snapshots}
mount -o noatime,compress=lzo,space_cache,subvol=@home $MNT_DRIVE /mnt/home
mount -o noatime,compress=lzo,space_cache,subvol=@srv $MNT_DRIVE /mnt/srv
mount -o noatime,compress=lzo,space_cache,subvol=@tmp $MNT_DRIVE /mnt/tmp
mount -o noatime,compress=lzo,space_cache,subvol=@opt $MNT_DRIVE /mnt/opt
mount -o noatime,compress=lzo,space_cache,subvol=@.snapshots $MNT_DRIVE /mnt/.snapshots
mount -o nodatacow,subvol=@swap $MNT_DRIVE /mnt/swap
mount -o nodatacow,subvol=@var $MNT_DRIVE /mnt/var
mount $BOOT_DRIVE /mnt/boot
