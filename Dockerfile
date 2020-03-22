FROM archlinux
# FROM oblique/archlinux-yay

WORKDIR /build 
ENV SID=aur
ENV UID=1000

RUN pacman -Syu --noconfirm \
&&  pacman -S --noconfirm git curl wget sudo base-devel \
&&  useradd -m -r -s /bin/bash aur  \
&&  passwd -d aur \
&&  echo 'aur ALL=(ALL) ALL' > /etc/sudoers.d/aur \
&&  mkdir -p /home/aur/.gnupg \
&&  echo 'standard-resolver' > /home/aur/.gnupg/dirmngr.conf \
&&  chown -R aur:aur /home/aur \ 
&&  chown -R aur:aur /build \
&&  cd /build \
&&  sudo -u aur git clone --depth 1 https://aur.archlinux.org/yay.git \
&&  cd yay \
&&  sudo -u aur makepkg --noconfirm -si \
&&  sudo -u aur yay --afterclean --removemake --save 

RUN sudo pacman -S --noconfirm tldr rsync lsd ranger archey3 xorg conky feh nitrogen rofi cmake \
    cairo libxcb python xcb-proto xcb-util-image xcb-util-wm unzip redshift \
    python-gobject docker atool ffmpegthumbnailer highlight libcaca mediainfo \
    odt2txt w3m tldr alacritty tmux compton xdotool yad dunst inotify-tools bat broot \
    gcc python-pip ttf-ibm-plex thefuck yarn npm neovim htop zathura zathura-pdf-mupdf \
    pandoc texlive-most \
&&  su aur -c 'yay -S --noconfirm nerd-fonts-hack i3lock-fancy' \
&&  pip install powerline-shell jedi neovim




ENV DISPLAY=:0

COPY entrypoint.sh /entrypoint.sh
COPY sudoers /etc/sudoers

CMD /bin/bash
ENTRYPOINT ["/entrypoint.sh"]
