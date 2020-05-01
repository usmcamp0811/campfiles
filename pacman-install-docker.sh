#!/bin/bash

# install programs used in docker container
pacman -Syu --noconfirm 
pacman -S --noconfirm neovim 

# about 90% of the things I need to get an arch install up
pacman -S --noconfirm rsync lsd ranger archey3 conky feh nitrogen rofi cmake \
    cairo libxcb python xcb-proto xcb-util-image xcb-util-wm unzip redshift \
    python-gobject docker atool ffmpegthumbnailer highlight libcaca mediainfo \
    odt2txt w3m tldr alacritty tmux compton xdotool yad dunst inotify-tools bat broot \
    gcc python-pip ttf-ibm-plex thefuck pandoc zathura zathura-pdf-mupdf ripgrep \
    openssh

# sudo -u aur yay -S --noconfigm polybar i3lock-fancy-git

git clone https://aur.archlinux.org/i3lock-fancy-git.git \
&& cd i3lock-fancy-git \
&& pacman -S --noconfirm imagemagick i3lock \
&& chown -R aur /build \
&& su aur -c 'makepkg && makepkg -i --noconfirm' \
&& pacman -U --noconfirm *.pkg.tar.xz

cd /build 
sudo -u aur yay -G polybar \
&& cd polybar \
&& pacman -S --noconfirm python-sphinx i3-wm libmpdclient \
&& chown -R aur /build \
&& su aur -c 'makepkg && makepkg -i --noconfirm' \
&& pacman -U --noconfirm *.pkg.tar.xz

# cd /build
# sudo -u aur yay -G python37 \
# && cd python37 \
# && pacman -S --noconfirm tk valgrind bluez-libs mpdecimal llvm gdb xorg-server-xvfb \
# && chown -R aur /build \
# && sudo -u aur gpg --recv-keys 2D347EA6AA65421D \
# && su aur -c 'makepkg && makepkg -i --noconfirm' \
# && pacman -U --noconfirm *.pkg.tar.xz

# install yay so we can get AUR stuff
# su aur -c 'yay -S --noconfirm nerd-fonts-hack i3lock-fancy polybar' 

pip install powerline-shell neovim jedi tldr.py pynvim pylint jupyter

pacman -Syu --noconfirm 
pacman -S --noconfirm pandoc texlive-core nodejs 
pacman -S --noconfirm npm 
# su aur -c 'yay -S --noconfirm python37' 
pacman -S --noconfirm xsel

# clean things up for docker
(echo -e "y\ny\n" | pacman -Scc)
