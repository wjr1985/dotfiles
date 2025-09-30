#!/bin/bash

set -e

# install required packages in one go (sorted alphabetically)
sudo pacman --noconfirm -S fish htop lsd ncdu nvim prettyping thefuck tmux ttf-meslo-nerd zoxide

# install fisher (fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# install fish plugins
#fish -c "fisher install PatrickF1/fzf.fish"

# install fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install the fish config from this repo
mkdir -p ~/.config/fish
cd ~/github/dotfiles

if grep -q "cachyos" /etc/os-release 2>/dev/null; then
    # Running on CachyOS - append source line to existing config
    if [ -f ~/.config/fish/config.fish ]; then
        echo "" >> ~/.config/fish/config.fish
        echo "# Source custom dotfiles config" >> ~/.config/fish/config.fish
        echo "source ~/.config/fish/config-custom.fish" >> ~/.config/fish/config.fish
    fi
    ln -s $PWD/config.fish ~/.config/fish/config-custom.fish
else
    # Not on CachyOS - use standard linking
    if [ -f ~/.config/fish/config.fish ]; then
        mv ~/.config/fish/config.fish ~/.config/fish/config.fish-bak
    fi
    ln -s $PWD/config.fish ~/.config/fish/config.fish
fi
