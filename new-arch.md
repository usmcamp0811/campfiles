
# for wifi
iwctl station wlan0 connect <SSID>

gdisk /dev/nvme0n1

# Wipe everything
o
Y <CR>

# EFI Partion 250MB
n
Partion number >> <CR>
First sector >> <CR>
Last secto >> +250M

Explore
 
￼ 
Hex code >> ef00

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
mkfs.vfat -F32 /dev/nvme0n1p1

# Setup the encryption of the system
cryptsetup -c aes-xts-plain64 -y --use-random luksFormat /dev/nvme0n1p2
cryptsetup luksOpen /dev/nvme0n1p2 luks

# Format with BTRFS
mkfs.btrfs /dev/mapper/luks 

mount /dev/mapper/luks /mnt

# Now make subvolumes
btrfs su cr /mnt/@

btrfs su cr /mnt/@home
btrfs su cr /mnt/@var
btrfs su cr /mnt/@srv
btrfs su cr /mnt/@opt
btrfs su cr /mnt/@tmp
btrfs su cr /mnt/@swap
btrfs su cr /mnt/@.snapshots

umount /mnt
mount -o noatime,compress=lzo,space_cache,subvol=@ /dev/mapper/luks /mnt
mkdir /mnt/{boot,home,var,srv,opt,tmp,swap,.snapshots}
mount -o noatime,compress=lzo,space_cache,subvol=@home /dev/mapper/luks /mnt/home
mount -o noatime,compress=lzo,space_cache,subvol=@srv /dev/mapper/luks /mnt/srv
mount -o noatime,compress=lzo,space_cache,subvol=@tmp /dev/mapper/luks /mnt/tmp
mount -o noatime,compress=lzo,space_cache,subvol=@opt /dev/mapper/luks /mnt/opt
mount -o noatime,compress=lzo,space_cache,subvol=@.snapshots /dev/mapper/luks /mnt/.snapshots
mount -o nodatacow,subvol=@swap /dev/mapper/luks /mnt/swap
mount -o nodatacow,subvol=@var /dev/mapper/luks /mnt/var
mount /dev/nvme0n1p1 /mnt/boot

# just double check things
lsblk


pacstrap /mnt base linux linux-lts linux-firmware neovim amd-ucode btrfs-progs
genfstab -U /mnt >> /mnt/etc/fstab

# double check 
cat /mnt/etc/fstab

arch-chroot /mnt

truncate -s 0 /swap/swapfile
chattr +C /swap/swapfile
btrfs property set /swap/swapfile compression none
dd if=/dev/zero of=/swap/swapfile bs=1G count=2 status=progress
chmod 600 /swap/swapfile
mkswap /swap/swapfile
swapon /swap/swapfile 

echo "/swap/swapfile none swap defaults 0 0" >> /etc/fstab

ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "en_US.UTF-8 UTF-8" >> /etc/locale.conf

echo "WOPR" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1 localhost" >> /etc/hosts

pacman -S grub grub-btrfs efibootmgr networkmanager network-manager-applet wpa_supplicant dialog os-prober dosfstools base-devel linux-headers git reflector bluez bluez-utils cups xdg-utils xdg-user-dirs openssh

# Edit `/etc/mkinitcpio.conf`
Add `btrfs` to the MODULES and add `encrypt` HOOKS after block
mkinitcpio -p linux
mkinitcpio -p linux-lts

# In /etc/default/grub edit the line GRUB_CMDLINE_LINUX to 
GRUB_CMDLINE_LINUX="cryptdevice=/dev/nvme0n1p2:luks:allow-discards quiet splash" 


# then run:
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg
systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups
systemctl enable sshd

useradd -mG wheel mcamp
passwd mcamp

EDITOR=nvim visudo
# uncomment out the `wheel` group line


# REBOOT

# WIFI
sudo nmcli --ask dev wifi connect <NETWORK SSID>

# Install Nvidia
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf 
sudo pacman -S linux linux-headers base-devel
sudo pacman -S nvidia-dkms

# Edit `/usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf`
```
sudo (text_editor) /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf
Add Option “PrimaryGPU” “Yes” to the file and save:
Section “OutputClass”
Identifier “nvidia”
MatchDriver “nvidia-drm”
Driver “nvidia”
Option “AllowEmptyInitialConfiguration”
ModulePath “/usr/lib/nvidia/xorg”
ModulePath “/usr/lib/xorg/modules”
Option “PrimaryGPU” “Yes”
EndSection
```
# Edit `/usr/share/X11/xorg.conf.d/10-amdgpu.conf`
```
sudo (text_editor) /usr/share/X11/xorg.conf.d/10-amdgpu.conf
Change driver to modesetting and save:
Section “OutputClass”
Identifier “AMDgpu”
MatchDriver “amdgpu”
Driver “modesetting”
EndSection
```

# Edit `/etc/lightdm/display_setup.sh`

```
#!/bin/sh
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
# uncomment if autorandr is installed and you have copied ~/.config/autorandr to /etc/xdg/autorandr
# autorandr --change --default laptop
```

`chmod +x /etc/lightdm/display_setup.sh`

# Edit `/etc/lightdm/lightdm.conf`

```
[Seat:*]
display-setup-script=/etc/lightdm/display_setup.sh
```


# Setup Snapper 

sudo pacman -S snapper 
sudo unoumt /.snapshots
sudo rm -r /.snapshots
sudo snapper -c root create-config /
sudo btrfs subvolume delete /.snapshots
sudo mkdir /.snapshots
sudo mount -a 
sudo chmod 750 /.snapshots
# edit `/etc/snapper/configs/root`
```
TIMELINE_LIMIT_HOURLY="5"
TIMELINE_LIMIT_DAILY="7"
TIMELINE_LIMIT_WEEKLY="0"
TIMELINE_LIMIT_MONTHLY="0"
TIMELINE_LIMIT_YEARLY="0"
```

yay -S snapper-gui snap-pac-grub

sudo nvim /etc/pacman.d/hooks/50-bootbackup.hook

```
[Trigger]
Operation = Upgrade
Operation = Install
Operation = Remove
Type = Path
Target = boot/*

[Action]
Depends = rsync
Description = Backing up /boot...
When = PreTransaction
Exec = /usr/bin/rsync -a --delete /boot /.bootbackup
```
