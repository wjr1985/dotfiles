#!/usr/bin/env bash

# Nord-themed tmux-powerline theme

# Default status bar colors
TMUX_POWERLINE_DEFAULT_BACKGROUND_COLOR="#2e3440"
TMUX_POWERLINE_DEFAULT_FOREGROUND_COLOR="#d8dee9"

# Segment format: "name bg fg separator sep_bg sep_fg spacing separator_toggle"

if [ -z "$TMUX_POWERLINE_LEFT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_LEFT_STATUS_SEGMENTS=(
		"prefix_indicator #2e3440 #d8dee9 ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN} no_sep_bg_color no_sep_fg_color both_disable separator_disable"
		"tmux_session_info #2e3440 #a3be8c ${TMUX_POWERLINE_SEPARATOR_RIGHT_THIN} #2e3440 #4c566a"
	)
fi

if [ -z "$TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS" ]; then
	TMUX_POWERLINE_RIGHT_STATUS_SEGMENTS=(
		"keyboard_hints #2e3440 #616e88 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} #2e3440 #4c566a"
		"now_playing #2e3440 #88c0d0 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} #2e3440 #4c566a"
		"time #2e3440 #d8dee9 ${TMUX_POWERLINE_SEPARATOR_LEFT_THIN} #2e3440 #4c566a"
	)
fi

# Clock with seconds
TMUX_POWERLINE_SEG_TIME_FORMAT="%H:%M"
