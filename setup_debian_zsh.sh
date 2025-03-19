#!/bin/bash

# install zsh
sudo apt-get install -y zsh

# install thefuck
sudo apt install -y thefuck

# install lsd
sudo apt install -y lsd

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-aliases-lsd
# git clone https://github.com/yuhonas/zsh-aliases-lsd #{ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-lsd

# install prettyping
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && sudo chmod a+x /usr/bin/prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
sudo apt-get install -y htop

# make sure neovim is installed
sudo add-apt-repository -y universe
sudo apt install -y libfuse2
wget https://github.com/neovim/neovim/releases/download/v0.10.4/nvim.appimage && sudo mv nvim.appimage /usr/local/bin/nvim && sudo chmod a+x /usr/local/bin/nvim

# get ncdu
sudo apt-get install -y ncdu

# get powerlevel 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
ln -s $PWD/p10k.zsh ~/.p10k.zsh

# install the zshrc from this repo
mv ~/.zshrc ~/.zshrc-bak
cd ~/github/dotfiles
ln -s $PWD/zshrc ~/.zshrc
