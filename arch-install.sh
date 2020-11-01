#!/bin/sh

# for wifi
iwctl station wlan0 connect <SSID>

gdisk /dev/sda
# EFI Partion 250MB
n
Partion number >> <CR>
First sector >> <CR>
Last secto >> +250M
Hex code >> ef00

# Boot Partition 500MB
n
Partion number >> <CR>
First sector >> <CR>
Last secto >> +250M
Hex code >> 8300

# Everything else
n
Partion number >> <CR>
First sector >> <CR>
Last secto >> <CR>
Hex code >> 8300

# verify everything it looks good
p

# write it 
w

# see what all the partitions are called
fdisk -l 

# the UEFI partition 
mkfs.vfat -F32 /dev/sda1

# Boot partition 
mkfs.ext4 /dev/sda2

# Setup the encryption of the system
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/sda3
cryptsetup luksOpen /dev/sda3 luks

# Create encrypted partitions
# This creates one partions for root, modify if /home or other partitions should be on separate partitions
pvcreate /dev/mapper/luks
vgcreate vg0 /dev/mapper/luks
lvcreate --size 50G vg1 --name root
lvcreate --size 72G vg0 --name docker
lvcreate -l +100%FREE vg0 --name home

# Create filesystems on encrypted partitions
mkfs.ext4 /dev/mapper/vg0-root
mkfs.ext4 /dev/mapper/vg0-home
mkfs.ext4 /dev/mapper/vg0-docker

# Mount the new system 
mount /dev/mapper/vg0-root /mnt # /mnt is the installed system
mkdir /mnt/boot
mount /dev/sda2 /mnt/boot
mkdir /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mkdir -p /mnt/var/lib/docker
mount /dev/mapper/vg0-docker /mnt/var/lib/docker
mkdir -p /mnt/home
mount /dev/mapper/vg0-home /mnt/home

# Install the system also includes stuff needed for starting wifi when first booting into the newly installed system
# Unless vim and bash are desired these can be removed from the command
pacstrap /mnt base base-devel grub-efi-x86_64 neovim git efibootmgr dialog wpa_supplicant bash mkinitcpio openssh linux-lts archey3 python-pip linux linux-firmware lvm2 autofs networkmanager netctl dhclient

# 'install' fstab
genfstab -pU /mnt >> /mnt/etc/fstab

# chroot into the new install
arch-chroot /mnt


# Make /tmp a ramdisk (add the following line to /mnt/etc/fstab)
tmpfs	/tmp	tmpfs	defaults,noatime,mode=1777	0	0
# Change relatime on all non-boot partitions to noatime (reduces wear if using an SSD)

# Setup system clock
ln -s /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc --utc

echo MYHOSTNAME > /etc/hostname

# Update locale
echo LANG=en_US >> /etc/locale.conf
echo LANGUAGE=en_US >> /etc/locale.conf
echo LC_ALL=C >> /etc/locale.conf

# Set password for root
passwd

# Add real user remove -s flag if you don't whish to use bash
useradd -m -g users -G wheel -s /bin/bash MYUSERNAME
passwd MYUSERNAME

# install yay
echo 'MYUSERNAME ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers 
git clone --depth 1 https://aur.archlinux.org/yay.git /home/MYUSERNAME/yay


sudo -u MYUSERNAME yay -S nerd-fonts-hack
pacman -S ttf-dejavu 

# might need this 
yay -S aic94xx-firmware wd719x-firmware


# Configure mkinitcpio with modules needed for the initrd image
vim /etc/mkinitcpio.conf
# Add 'ext4' to MODULES
# Add 'encrypt' and 'lvm2' to HOOKS before filesystems

pip install powerline-shell
# Regenerate initrd image
mkinitcpio -p linux
mkinitcpio -p linux-lts

# Setup grub
grub-install

# In /etc/default/grub edit the line GRUB_CMDLINE_LINUX to 
GRUB_CMDLINE_LINUX="cryptdevice=/dev/sda3:luks:allow-discards quiet splash" 


# then run:
grub-mkconfig -o /boot/grub/grub.cfg

# go a head and install plymouth now.. 
sudo -u MYUSERNAME yay -S plymouth plymouth-theme-dark-arch
# NOTE: Don't use Plymouth till you get lightdm installed.. else you might get stuck in a boot loop
# lightdm can't be installed in chroot
git clone https://github.com/usmcamp0811/campfiles.git /home/MYUSERNAME/campfiles
cp /home/MYUSERNAME/campfiles/root-files/mkinitcpio.conf /etc/mkinitcpio.conf

# enable NetworkManager or you wont have itnernet
systemctl enable NetworkManager.service
systemctl start NetworkManager.service

# post install
pacman -S --needed lightdm i3-gaps i3blocks i3status ranger  \
    nodejs npm broot lightdm-webkit2-greeter lightdm-webkit-theme-litarvan

yay -S plymouth grub2-theme-archlinux plymouth-theme-dark-arch 

/bin/bash ./grub-plymouth.conf 
