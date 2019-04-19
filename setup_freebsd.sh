#!/bin/bash

# install zsh
sudo pkg install -y zsh

# install oh-my-zsh
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh

# install bat
sudo pkg install -y bat

# make sure wget is installed
sudo pkg install -y wget

# install prettyping
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && sudo chmod a+x /usr/bin/prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
sudo pkg install -y htop

# make sure vim is installed
sudo pkg install -y vim

# get my vim dotfiles
mkdir -p ~/github && cd ~/github && git clone git@github.com:wjr1985/vim_dotfiles && cd vim_dotfiles && ./activate.sh

# get git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/git-prompt.sh

# get ncdu
sudo pkg install -y ncdu

# get pure shell
mkdir ~/.zfunctions
cd ~/github && git clone git@github.com:sindresorhus/pure && cd pure && ln -s "$PWD/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup" && ln -s "$PWD/async.zsh" "$HOME/.zfunctions/async"

# install the zshrc from this repo
mv ~/.zshrc ~/.zshrc-bak
ln -s /home/billr/github/dotfiles/zshrc ~/.zshrc

# switch to zsh
chsh -s /usr/local/bin/zsh
