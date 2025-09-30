# Fish shell configuration

# Skip Homebrew setup on Bazzite OS
if not grep -q "bazzite" /etc/os-release 2>/dev/null
    # Original Homebrew setup logic
    if command -v arch >/dev/null 2>&1
        if test (arch) = "arm64"
            test -s "/opt/homebrew/bin/brew"; and eval "$(/opt/homebrew/bin/brew shellenv)"
        else
            test -s "/usr/local/bin/brew"; and eval "$(/usr/local/bin/brew shellenv)"
        end
    end
end

# bat alias
if command -v bat >/dev/null 2>&1
    alias cat 'bat'
end

# prettyping alias
if command -v prettyping >/dev/null 2>&1
    alias ping 'prettyping --nolegend'
end

# htop alias
if command -v htop >/dev/null 2>&1
    alias top 'htop'
end

# ncdu alias
if command -v ncdu >/dev/null 2>&1
    alias du 'ncdu -rr'
end

# exa alias
if command -v exa >/dev/null 2>&1
    alias ls 'exa'
end

# git alias
alias g 'git'

# editor
set -gx EDITOR vim

# thefuck integration
if command -v thefuck >/dev/null 2>&1
    thefuck --alias | source
end

# tmuxinator alias
if command -v tmuxinator >/dev/null 2>&1
    alias tm 'tmuxinator'
end

# nvim aliases
if command -v nvim >/dev/null 2>&1
    alias vim 'nvim'
    alias vi 'nvim'
    alias vimdiff 'nvim -d'
    set -gx EDITOR nvim
end

# Load local config if exists
if test -f ~/.config/fish/local.fish
    source ~/.config/fish/local.fish
end

# whatismyip alias
alias whatismyip 'dig TXT +short o-o.myaddr.l.google.com @ns1.google.com | awk -F"\"" "{ print \$2}"'

# ytmp3 function
function ytmp3
    yt-dlp -x --audio-format mp3 --audio-quality 0 $argv[1]
end

# fzf integration
if test -f ~/.fzf/shell/key-bindings.fish
    source ~/.fzf/shell/key-bindings.fish
end

# Git prompt configuration - show detailed git status
set -g __fish_git_prompt_showdirtystate 'yes'
set -g __fish_git_prompt_showstashstate 'yes'
set -g __fish_git_prompt_showuntrackedfiles 'yes'
set -g __fish_git_prompt_showupstream 'auto'
set -g __fish_git_prompt_showcolorhints 'yes'

# Git prompt characters (matching starship defaults)
set -g __fish_git_prompt_char_stateseparator ' '
set -g __fish_git_prompt_char_dirtystate '*'
set -g __fish_git_prompt_char_stagedstate '+'
set -g __fish_git_prompt_char_untrackedfiles '?'
set -g __fish_git_prompt_char_stashstate '$'
set -g __fish_git_prompt_char_upstream_ahead '⇡'
set -g __fish_git_prompt_char_upstream_behind '⇣'
set -g __fish_git_prompt_char_upstream_diverged '⇕'
set -g __fish_git_prompt_char_upstream_equal ''

# Git prompt colors
set -g __fish_git_prompt_color_branch yellow
set -g __fish_git_prompt_color_dirtystate red
set -g __fish_git_prompt_color_stagedstate green
set -g __fish_git_prompt_color_untrackedfiles cyan
set -g __fish_git_prompt_color_upstream magenta

# Custom prompt with git info
function fish_prompt
    set -l last_status $status

    # User and host
    set_color cyan
    printf '%s' $USER
    set_color normal
    printf '@'
    set_color green
    printf '%s' (prompt_hostname)
    set_color normal
    printf ' '

    # Current directory
    set_color blue
    printf '%s' (prompt_pwd)
    set_color normal

    # Git info
    printf '%s' (fish_git_prompt)

    # Status indicator
    if test $last_status -ne 0
        set_color red
        printf ' [%d]' $last_status
    end

    set_color normal
    printf '\n❯ '
end

alias ls 'lsd'
alias exa 'lsd'
alias ll 'lsd -l'
alias la 'lsd -la'
