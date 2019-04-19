#!/bin/bash

PATH=$PATH:/usr/local/bin

if [ -f ~/git-prompt.sh ]; then
  GIT_PS1_SHOWUPSTREAM="verbose"
  GIT_PS1_SHOWUNTRACKEDFILES="yes"
  GIT_PS1_SHOWCOLORHINTS="yes"
  GIT_PS1_SHOWDIRTYSTATE="yes"
  source ~/git-prompt.sh
  PROMPT_COMMAND='__git_ps1 "\[\e[0;32m\]\h\[\e[1;37m\]:\[\e[1;36m\]\w\[\e[0m\]" "\\\$ "'
else
  PS1='\[\]\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx
alias ls='ls --color=auto'

# brew section
which brew 2>/dev/null 1>/dev/null
BREW_INSTALLED=$?

if [ $BREW_INSTALLED -eq 0 ]; then
  # bash completion for OS X
  if [ -f `brew --prefix`/etc/bash_completion ]; then
      . `brew --prefix`/etc/bash_completion
  fi

  if [ -f $(brew --repository)/Library/Contributions/brew_bash_completion.sh ]; then
    source $(brew --repository)/Library/Contributions/brew_bash_completion.sh
  fi
fi

which bat 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias cat='bat'
fi

which prettyping 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias ping='prettyping --nolegend'
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

which htop 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias top='htop'
fi

which ncdu 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias du='ncdu -rr'
fi


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

EDITOR=vim

# THIS SHOULD BE LAST
if [ -f ~/.bash_local ]; then
  source ~/.bash_local
fi

