# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
#if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
#fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

fpath=( "$HOME/.zfunctions" $fpath )

# Path to your oh-my-zsh installation.
# if [[ "$OSTYPE" == "linux-gnu" ]]; then
  export ZSH="$HOME/.oh-my-zsh"
# if [[ "$OSTYPE" == "linux-gnu" ]]; then
#   export ZSH="/home/billr/.oh-my-zsh"
# elif [[ "$OSTYPE" == "darwin" ]]; then
#   export ZSH="/Users/billr/.oh-my-zsh"
# elif [[ "$OSTYPE" == "freebsd" ]]; then
#   export ZSH="/Users/billr/.oh-my-zsh"
# else
#   export ZSH="/home/billr/.oh-my-zsh"
# fi

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ `uname` == "Darwin" ]]; then
  plugins=(git zsh-syntax-highlighting vi-mode macos zsh-autosuggestions zsh-aliases-lsd)
else
  plugins=(git zsh-syntax-highlighting vi-mode zsh-autosuggestions zsh-aliases-lsd)
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
AGKOZAK_PROMPT_DIRTRIM=0
AGKOZAK_CUSTOM_SYMBOLS=( '⇣⇡' '⇣' '⇡' '+' 'x' '!' '>' '?' )

# Uncomment this if you want to use the pure ZSH theme
  # Make sure to unset ZSH_THEME above
# autoload -U promptinit; promptinit
# prompt pure
# PROMPT='%F{white}%* '$PROMPT


# Skip Homebrew setup on Bazzite OS
if grep -q "bazzite" /etc/os-release 2>/dev/null; then
  # Running on Bazzite, skip Homebrew setup
  :
else
  # Original Homebrew setup logic
  which arch 2>/dev/null 1>/dev/null
  if [ $? -eq 0 ]; then
    if [ "$(arch)" = "arm64" ]; then
      [[ -s "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
    else
      [[ -s "/usr/local/bin/brew" ]] && eval "$(/usr/local/bin/brew shellenv)"
    fi
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

which htop 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias top='htop'
fi

which ncdu 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias du='ncdu -rr'
fi

which exa 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias ls='exa'
fi

alias g='git'
# Uncomment this if using pure
# alias fix-git-prompt='prompt_pure_async_init=0; async_stop_worker prompt_pure'

unsetopt auto_name_dirs

export EDITOR=vim
which thefuck 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  eval $(thefuck --alias)
fi

unsetopt nomatch

which tmuxinator 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias tm='tmuxinator'
fi

# alias nvim to vim if it exists
which nvim 2>/dev/null 1>/dev/null
if [ $? -eq 0 ]; then
  alias vim='nvim'
  alias vi='nvim'
  alias vimdiff='nvim -d'
  export EDITOR=nvim
fi

if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

alias whatismyip='dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F"\"" "{ print \$2}"'

ytmp3() {
    yt-dlp -x --audio-format mp3 --audio-quality 0 "$1"
}

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"
# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
#[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(starship init zsh)"
