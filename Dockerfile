FROM archlinux
# FROM oblique/archlinux-yay

WORKDIR /build 

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

USER root


RUN pacman -S --noconfirm neovim \ 
&&  pacman -S --noconfirm tldr rsync lsd ranger archey3 xorg conky feh nitrogen rofi cmake \
    cairo libxcb python xcb-proto xcb-util-image xcb-util-wm unzip redshift \
    python-gobject docker atool ffmpegthumbnailer highlight libcaca mediainfo \
    odt2txt w3m tldr alacritty tmux compton xdotool yad dunst inotify-tools bat broot \
    gcc python-pip ttf-ibm-plex thefuck pandoc zathura zathura-pdf-mupdf ripgrep \
&&  su aur -c 'yay -S --noconfirm nerd-fonts-hack i3lock-fancy' \
&&  pip install powerline-shell neovim jedi



COPY entrypoint.sh /entrypoint.sh
COPY .bashrc /etc/skel/.bashrc
COPY sudoers /etc/sudoers
COPY ./dotfiles /home/aur

ENV DISPLAY=:0
ENV SID=aur
ENV UID=1000
ENV GID=1000

CMD /bin/bash
ENTRYPOINT ["/entrypoint.sh"]
