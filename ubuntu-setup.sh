#!/bin/bash
export DEBIAN_FRONTEND='noninteractive' 

# RUN apt-get update \
apt-get update \
&&  apt-get install -y software-properties-common \
&&  add-apt-repository -y ppa:neovim-ppa/stable \
&&  add-apt-repository -y ppa:deadsnakes/ppa \
&&  add-apt-repository -y ppa:lazygit-team/release \
&&  apt-get update -y \
&&  apt-get install -y git neovim cargo tmux w3m wget rsync zathura python3.8 mpv npm yarn \
&&  apt-get install -y mupdf xsel unzip nodejs fonts-ibm-plex lazygit compton ranger htop bat \
&&  apt-get install -y docker fzf docker-compose rsync xdotool pandoc w3m odt2txt gcc openssh-client \
&&  apt-get install -y autoconf 
&&  cargo install alacritty 
&&  cargo install lsd \
# &&  cargo install broot \
# Julia Install cause Ubuntu's repos are shit! 
&&  wget https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.2-linux-x86_64.tar.gz \
&&  tar -xvzf julia-1.5.2-linux-x86_64.tar.gz \
&&  sudo cp -r julia-1.5.2 /opt/ \
&&  sudo ln -s /opt/julia-1.5.2/bin/julia /usr/local/bin/julia \
&& git clone https://github.com/ryanoasis/nerd-fonts.git /build/nerd-fonts \
&&  rm -rf /var/lib/apt/lists/*

export PATH=/root/.cargo/bin:$PATH
alias python='/usr/bin/python3.8'
alias cat='batcat'

# &&  add-apt-repository -y ppa:webupd8team/java \
# &&  add-apt-repository -y ppa:ferramroberto/linuxfreedomlucid \
# redhsift
