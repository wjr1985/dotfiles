#!/usr/bin/env bash

# tmux-powerline configuration

# Use custom Nord theme
export TMUX_POWERLINE_THEME="nord"
# Point to our custom themes/segments in ~/.config/tmux-powerline/
export TMUX_POWERLINE_DIR_USER_THEMES="\${XDG_CONFIG_HOME:-\$HOME/.config}/tmux-powerline/themes"
export TMUX_POWERLINE_DIR_USER_SEGMENTS="\${XDG_CONFIG_HOME:-\$HOME/.config}/tmux-powerline/segments"

# Status bar refresh interval in seconds
export TMUX_POWERLINE_STATUS_INTERVAL=15

# Status bar lengths (main.tmux overrides tmux.conf, so set them here)
export TMUX_POWERLINE_STATUS_LEFT_LENGTH=60
export TMUX_POWERLINE_STATUS_RIGHT_LENGTH=200

# Use pipe separators instead of powerline arrows
export TMUX_POWERLINE_SEPARATOR_LEFT_BOLD="│"
export TMUX_POWERLINE_SEPARATOR_LEFT_THIN="│"
export TMUX_POWERLINE_SEPARATOR_RIGHT_BOLD="│"
export TMUX_POWERLINE_SEPARATOR_RIGHT_THIN="│"

# Session info — show only session name (not window:pane)
export TMUX_POWERLINE_SEG_TMUX_SESSION_INFO_FORMAT="#S"

# Now Playing — Last.fm
export TMUX_POWERLINE_SEG_NOW_PLAYING_MUSIC_PLAYER="lastfm"
export TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_USERNAME="${LASTFM_USERNAME}"
export TMUX_POWERLINE_SEG_NOW_PLAYING_LASTFM_API_KEY="${LASTFM_API_KEY}"
export TMUX_POWERLINE_SEG_NOW_PLAYING_UPDATE_PERIOD="30"
export TMUX_POWERLINE_SEG_NOW_PLAYING_MAX_LEN="40"
export TMUX_POWERLINE_SEG_NOW_PLAYING_NOTE_CHAR="♫"
