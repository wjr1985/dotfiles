#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# check for homebrew
if ! command -v brew &>/dev/null; then
    echo "Error: Homebrew is not installed. Install it first: https://brew.sh"
    exit 1
fi

# install packages via brew (idempotent — skips already installed)
brew install zsh bat htop lsd ncdu neovim prettyping starship thefuck tmux zoxide
brew install --cask font-meslo-lg-nerd-font

# install oh-my-zsh (skip if already installed)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended || true
fi

# install zsh plugins (skip each if already cloned)
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"

[ -d "$ZSH_CUSTOM/plugins/zsh-aliases-lsd" ] || \
    git clone https://github.com/yuhonas/zsh-aliases-lsd "$ZSH_CUSTOM/plugins/zsh-aliases-lsd"

# install fzf (clone if missing, always run install for idempotent recovery)
if [ ! -d "$HOME/.fzf" ]; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
~/.fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish

# symlink zshrc (backup existing non-symlink)
if [ -f ~/.zshrc ] && [ ! -L ~/.zshrc ]; then
    mv ~/.zshrc ~/.zshrc-bak
fi
ln -sf "$DOTFILES_DIR/zshrc" ~/.zshrc

# setup starship config
mkdir -p ~/.config
ln -sf "$DOTFILES_DIR/starship_config.toml" ~/.config/starship.toml

# setup tmux + tmux-powerline
"$DOTFILES_DIR/setup_tmux.sh"
