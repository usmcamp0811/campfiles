FROM archlinux
# FROM oblique/archlinux-yay
ENV XDG_CONFIG_HOME="$HOME/.config"

WORKDIR /build 

ENV DISPLAY=:0
ENV SID=aur
ENV UID=1000
ENV GID=1000

COPY ./pacman-install-docker.sh /pacman-install-docker.sh 

USER root

RUN pacman -Syu --noconfirm \
&&  pacman -S --noconfirm git curl wget sudo base-devel \
&&  useradd -m -r -s /bin/bash aur  \
&&  passwd -d aur \
&&  echo 'aur ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/aur \
&&  mkdir -p /home/aur/.gnupg \
&&  echo 'standard-resolver' > /home/aur/.gnupg/dirmngr.conf \
&&  chown -R aur:aur /home/aur \ 
&&  chown -R aur:aur /build \
&&  cd /build \
&&  sudo -u aur git clone --depth 1 https://aur.archlinux.org/yay.git \
&&  cd yay \
&&  sudo -u aur makepkg --noconfirm -si \
&&  sudo -u aur yay --afterclean --removemake --save \
&&  /pacman-install-docker.sh

COPY . /build 

RUN rm -rf /home/aur \
&&  git clone --separate-git-dir=/home/aur/.dotfiles https://github.com/usmcamp0811/dotfiles.git /home/aur \
&&  chown -R aur:aur /home/aur \
&&  cd /home/aur \
&&  sudo -u aur /usr/bin/nvim -E -s -u '/build/pluginstall.vim' +PlugInstall +qall > /dev/null \
&&  cd /home/aur/.config/coc/extensions \
&&  sudo -u aur npm i \
&&  chown root /build/sudoers \
&&  mv /build/sudoers /etc/sudoers \
&&  mv /build/entrypoint.sh /entrypoint.sh \
&&  mkdir -p /root/.config/ \
&&  cp /home/aur/.config/archey3.cfg /root/.config/archey3.cfg \
&&  sudo -u aur yay -S --noconfirm nerd-fonts-hack

WORKDIR /home/aur

ENTRYPOINT ["/entrypoint.sh"]
