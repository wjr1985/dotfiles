#!/usr/bin/env bash

# Custom segment: prefix indicator with Nord colors
# Changes color when tmux prefix key (C-b) is active

run_segment() {
	echo "#{?client_prefix,#[bg=#bf616a fg=#2e3440 bold] C-b #[default],#[bg=#3b4252 fg=#616e88] C-b #[default]}"
	return 0
}
