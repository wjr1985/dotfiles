#!/bin/bash

set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# symlink tmux config
ln -sf "$DOTFILES_DIR/tmux.conf" ~/.tmux.conf

# install tpm (Tmux Plugin Manager)
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# symlink tmux-powerline config
mkdir -p ~/.config/tmux-powerline/themes
mkdir -p ~/.config/tmux-powerline/segments
ln -sf "$DOTFILES_DIR/tmux-powerline/config.sh" ~/.config/tmux-powerline/config.sh
ln -sf "$DOTFILES_DIR/tmux-powerline/themes/nord.sh" ~/.config/tmux-powerline/themes/nord.sh
ln -sf "$DOTFILES_DIR/tmux-powerline/segments/keyboard_hints.sh" ~/.config/tmux-powerline/segments/keyboard_hints.sh
ln -sf "$DOTFILES_DIR/tmux-powerline/segments/prefix_indicator.sh" ~/.config/tmux-powerline/segments/prefix_indicator.sh

echo "tmux setup complete — open tmux and press C-b I to install plugins"
