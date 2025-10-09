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

# ASDF configuration code
if test -d "$HOME/.asdf"; or test -n "$ASDF_DATA_DIR"
    if test -z $ASDF_DATA_DIR
        set _asdf_shims "$HOME/.asdf/shims"
    else
        set _asdf_shims "$ASDF_DATA_DIR/shims"
    end

    # Do not use fish_add_path (added in Fish 3.2) because it
    # potentially changes the order of items in PATH
    if not contains $_asdf_shims $PATH
        set -gx --prepend PATH $_asdf_shims
    end
    set --erase _asdf_shims
end

# Skip pure settings on CachyOS
if not grep -q "cachyos" /etc/os-release 2>/dev/null
    set --universal pure_show_system_time true
    set --universal pure_enable_git true
end

alias ls 'lsd'
alias exa 'lsd'
alias ll 'lsd -l'
alias la 'lsd -la'

# zoxide integration
if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end
