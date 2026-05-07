#!/bin/bash

set -e

# install required packages from apt (sorted alphabetically)
sudo apt-get update
sudo apt-get install -y curl fish fontconfig htop lsd ncdu tmux unzip wget zoxide

# install neovim (apt's neovim is too old; grab the latest AppImage)
sudo apt-get install -y libfuse2
wget https://github.com/neovim/neovim/releases/download/v0.12.2/nvim-linux-x86_64.appimage
sudo mv nvim-linux-x86_64.appimage /usr/local/bin/nvim
sudo chmod a+x /usr/local/bin/nvim

# install starship
curl -sS https://starship.rs/install.sh | sh -s -- -y

# install prettyping
sudo wget -P /usr/bin/ https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
sudo chmod a+x /usr/bin/prettyping

# install MesloLGS Nerd Font
mkdir -p ~/.local/share/fonts
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip
unzip -o Meslo.zip -d ~/.local/share/fonts/Meslo
rm Meslo.zip
fc-cache -fv

# install fisher (fish plugin manager)
fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# install fish plugins
#fish -c "fisher install PatrickF1/fzf.fish"

# install fzf
#git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install the fish config from this repo
mkdir -p ~/.config/fish
cd ~/github/dotfiles

if [ -f ~/.config/fish/config.fish ]; then
    mv ~/.config/fish/config.fish ~/.config/fish/config.fish-bak
fi
ln -s $PWD/config.fish ~/.config/fish/config.fish

# setup starship config
ln -sf $PWD/starship_config.toml ~/.config/starship.toml

# setup tmux + tmux-powerline
"$PWD/setup_tmux.sh"
