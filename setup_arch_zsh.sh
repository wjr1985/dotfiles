#!/bin/bash

set -e

# install zsh
sudo pacman --noconfirm -S zsh

# install thefuck
sudo pacman --noconfirm -S thefuck

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install prettyping
sudo pacman --noconfirm -S prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
sudo pacman --noconfirm -S htop

# make sure neovim is installed
sudo pacman --noconfirm -S neovim

# get ncdu
sudo pacman --noconfirm -S ncdu

# # get pure shell
# mkdir ~/.zfunctions
# cd ~/github && git clone git@github.com:sindresorhus/pure && cd pure && ln -s "$PWD/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup" && ln -s "$PWD/async.zsh" "$HOME/.zfunctions/async"
#
# get powerlevel 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
ln -s $PWD/p10k.zsh ~/.p10k.zsh

# install the zshrc from this repo
mv ~/.zshrc ~/.zshrc-bak
cd ~/github/dotfiles
ln -s $PWD/zshrc ~/.zshrc
