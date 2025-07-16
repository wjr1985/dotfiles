#!/bin/bash

set -e

# Function to install a package if it's not already installed
install_if_missing() {
    local package="$1"
    local command_name="${2:-$1}"  # Use second argument as command name if provided, otherwise use package name
    
    # Special case for neovim
    if [ "$package" = "neovim" ] && [ "$command_name" = "neovim" ]; then
        command_name="nvim"
    fi
    
    # First check if the command exists in PATH
    if command -v "$command_name" &> /dev/null; then
        echo "$package is already installed in PATH (as $command_name), skipping..."
    else
        # If not in PATH, check if it's installed via Homebrew
        if brew list --formula 2>/dev/null | grep -q "^$package$"; then
            echo "$package is already installed via Homebrew, skipping..."
        else
            echo "Installing $package..."
            brew install $package
        fi
    fi
}

# install zsh
install_if_missing zsh

# install thefuck
install_if_missing thefuck

# install lsd
install_if_missing lsd

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# install zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# install zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# install zsh-aliases-lsd
git clone https://github.com/yuhonas/zsh-aliases-lsd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-aliases-lsd

# install starship
install_if_missing starship

# install bat
# wget https://github.com/sharkdp/bat/releases/download/v0.6.0/bat_0.6.0_amd64.deb && sudo dpkg -i bat_0.6.0_amd64.deb && rm bat_0.6.0_amd64.deb

# install prettyping
install_if_missing prettyping

# install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

# install htop
install_if_missing htop

# make sure neovim is installed
install_if_missing neovim

# get ncdu
install_if_missing ncdu

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
mkdir -p ~/.config
ln -s $PWD/starship_config.toml ~/.config/starship.toml
