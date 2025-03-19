#!/bin/bash

# install zsh
brew install zsh

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install lsd
brew install lsd

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-aliases-lsd
git clone https://github.com/yuhonas/zsh-aliases-lsd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-lsd

# install wget
brew install wget

# install bat
wget https://github.com/sharkdp/bat/releases/download/v0.6.0/bat_0.6.0_amd64.deb && sudo dpkg -i bat_0.6.0_amd64.deb && rm bat_0.6.0_amd64.deb

# install prettyping
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping && sudo chmod a+x /usr/bin/prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
brew install htop

# install neovim
brew install neovim

# alias neovim to vim
alias vim="nvim"
alias vi="nvim"
alias vimdiff='nvim -d'
export EDITOR=nvim

# get my vim dotfiles
mkdir -p ~/github && cd ~/github && git clone git@github.com:wjr1985/vim_dotfiles && cd vim_dotfiles && ./activate.sh

# get git-prompt.sh
wget https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh -O ~/git-prompt.sh

# get ncdu
brew install ncdu

# # get pure shell
# mkdir ~/.zfunctions
# cd ~/github && git clone git@github.com:sindresorhus/pure && cd pure && ln -s "$PWD/pure.zsh" "$HOME/.zfunctions/prompt_pure_setup" && ln -s "$PWD/async.zsh" "$HOME/.zfunctions/async"

# get powerlevel 10k
cd ~/github/dotfiles
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/themes/powerlevel10k
ln -s $PWD/p10k.zsh ~/.p10k.zsh

# get forgit
git clone --depth=1 https://github.com/wfxr/forgit.git ~/.oh-my-zsh/plugins/forgit

# install the zshrc from this repo
mv ~/.zshrc ~/.zshrc-bak
cd ~/github/dotfiles
ln -s $PWD/zshrc ~/.zshrc
