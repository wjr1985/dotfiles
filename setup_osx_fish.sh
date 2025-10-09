#!/bin/bash

set -e

# install fish
brew install fish

# install other tools via brew
brew install bat htop lsd ncdu neovim prettyping thefuck tmux zoxide

# install fisher (fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# install fish plugins
#fish -c "fisher install PatrickF1/fzf.fish"
fish -c "fisher install jorgebucaran/autopair.fish"
fish -c "fisher install pure-fish/pure"

# install fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --no-bash --no-zsh --all

# install the fish config from this repo
mkdir -p ~/.config/fish
if [ -f ~/.config/fish/config.fish ]; then
  mv ~/.config/fish/config.fish ~/.config/fish/config.fish-bak
fi
cd ~/github/dotfiles
ln -s $PWD/config.fish ~/.config/fish/config.fish
