#!/bin/bash


# install programs used in docker container
pacman -Syu --noconfirm 
pacman -S --noconfirm neovim 

# about 90% of the things I need to get an arch install up
pacman -S --noconfirm tldr rsync lsd ranger archey3 xorg conky feh nitrogen rofi cmake \
    cairo libxcb python xcb-proto xcb-util-image xcb-util-wm unzip redshift \
    python-gobject docker atool ffmpegthumbnailer highlight libcaca mediainfo \
    odt2txt w3m tldr alacritty tmux compton xdotool yad dunst inotify-tools bat broot \
    gcc python-pip ttf-ibm-plex thefuck pandoc zathura zathura-pdf-mupdf ripgrep \

# install yay so we can get AUR stuff
su aur -c 'yay -S --noconfirm nerd-fonts-hack i3lock-fancy' 

pip install powerline-shell neovim jedi 

pacman -Syu --noconfirm 
pacman -S --noconfirm pandoc texlive-most nodejs 
pacman -S --noconfirm npm 
su aur -c 'yay -S --noconfirm python37' 
pacman -S --noconfirm xsel

# clean things up for docker
(echo -e "y\ny\n" | pacman -Scc)
