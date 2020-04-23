FROM archlinux
# FROM oblique/archlinux-yay
ENV XDG_CONFIG_HOME="$HOME/.config"

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

COPY ./pacman-install-docker.sh /pacman-install-docker.sh 
RUN /pacman-install-docker.sh 

COPY ./dotfiles /home/aur


COPY .bashrc /etc/skel/.bashrc
COPY sudoers /etc/sudoers
COPY id-clone /build/id-clone
COPY entrypoint.sh /entrypoint.sh

ENV DISPLAY=:0
ENV SID=aur
ENV UID=1000
ENV GID=1000

CMD /bin/bash
ENTRYPOINT ["/entrypoint.sh"]
