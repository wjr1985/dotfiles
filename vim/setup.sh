#!/bin/bash

set -e

dotfiles_dir=$(cd "$(dirname "$0")"; pwd)

mkdir -p "${HOME}/.config/nvim/"

cat > "${HOME}/.config/nvim/init.vim"<< EOF
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
EOF

for name in vim vimrc vimrc.bundles; do
  rm -rf "${HOME}/.${name}"
  ln -s "${dotfiles_dir}/${name}" "${HOME}/.${name}"
done

nvim +PlugInstall +UpdateRemotePlugins +PlugClean! +qall
