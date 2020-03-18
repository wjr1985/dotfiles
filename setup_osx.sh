#!/bin/bash

which brew 2>/dev/null 1>/dev/null

if [ $? -ne 0 ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew install bat
brew install prettyping
brew install fzf
$(brew --prefix)/opt/fzf/install
brew install htop
