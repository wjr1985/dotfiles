#!/bin/bash

# install bat
wget https://github.com/sharkdp/bat/releases/download/v0.6.0/bat_0.6.0_amd64.deb && sudo dpkg -i bat_0.6.0_amd64.deb && rm bat_0.6.0_amd64.deb

# install prettyping
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && sudo chmod a+x /usr/bin/prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
sudo apt-get install htop

# make sure vim is installed
sudo apt-get install vim

# get my vim dotfiles
mkdir -p ~/github && cd ~/github && git clone git@gitlab.com:wjr1985/vim_dotfiles && cd vim_dotfiles && ./activate.sh

# get git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/git-prompt.sh

# get ncdu
sudo apt-get install ncdu
