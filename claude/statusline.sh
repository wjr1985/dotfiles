#!/usr/bin/env bash

# Read JSON input once
input=$(cat)

# Extract every field in a single jq pass (one process instead of ~12).
# Fields are joined with the ASCII unit separator (0x1F): unlike a tab it is not
# whitespace, so `read` won't collapse runs of it and empty/absent fields keep
# their slot. Absent values default to "" (or 0) below and read back as empty.
IFS=$'\037' read -r \
    MODEL DIR COST DURATION_MS TOTAL_TOKENS CONTEXT_PCT EFFORT EXCEEDS_200K \
    LINES_ADDED LINES_REMOVED SESSION_ID \
    FIVE_H_PCT FIVE_H_RESET WEEK_PCT WEEK_RESET \
    <<< "$(echo "$input" | jq -r '
        [
            .model.display_name // "",
            .workspace.current_dir // "",
            (.cost.total_cost_usd // 0),
            (.cost.total_api_duration_ms // 0),
            ((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)),
            (.context_window.used_percentage // 0 | floor),
            (.effort.level // ""),
            (.exceeds_200k_tokens // false),
            (.cost.total_lines_added // 0),
            (.cost.total_lines_removed // 0),
            (.session_id // ""),
            (.rate_limits.five_hour.used_percentage // ""),
            (.rate_limits.five_hour.resets_at // ""),
            (.rate_limits.seven_day.used_percentage // ""),
            (.rate_limits.seven_day.resets_at // "")
        ] | map(tostring) | join("")
    ')"

# ANSI colors
GREEN='\033[32m'
YELLOW='\033[33m'
RED='\033[31m'
RESET='\033[0m'

# Map an integer percentage to a threshold color (green <70, yellow 70-89, red >=90)
pct_color() {
    if [ "$1" -ge 90 ]; then echo "$RED"
    elif [ "$1" -ge 70 ]; then echo "$YELLOW"
    else echo "$GREEN"; fi
}

# Auto-scale a millisecond duration to the largest sensible unit.
# ms -> s -> m -> h -> d -> mo -> y, showing a second unit for the larger scales.
# Month/year use approximate 30d/365d for the (hopefully unreachable) high end.
fmt_duration() {
    local ms=$1
    if [ "$ms" -lt 1000 ]; then echo "${ms}ms"; return; fi
    local s=$((ms / 1000))
    if [ "$s" -lt 60 ]; then echo "${s}s"; return; fi
    local m=$((s / 60))
    if [ "$m" -lt 60 ]; then echo "${m}m $((s % 60))s"; return; fi
    local h=$((m / 60))
    if [ "$h" -lt 24 ]; then echo "${h}h $((m % 60))m"; return; fi
    local d=$((h / 24))
    if [ "$d" -lt 30 ]; then echo "${d}d $((h % 24))h"; return; fi
    local mo=$((d / 30))
    if [ "$mo" -lt 12 ]; then echo "${mo}mo $((d % 30))d"; return; fi
    echo "$((mo / 12))y $((mo % 12))mo"
}

# Countdown to a future epoch timestamp, reusing fmt_duration for consistent units.
fmt_reset() {
    local delta=$(( $1 - $(date +%s) ))
    if [ "$delta" -le 0 ]; then echo "now"; return; fi
    fmt_duration $((delta * 1000))
}

# Humanize a token count: 999 -> 999, 155000 -> 155k, 1234567 -> 1.2M
fmt_tokens() {
    local n=$1
    if [ "$n" -lt 1000 ]; then echo "$n"
    elif [ "$n" -lt 1000000 ]; then echo "$((n / 1000))k"
    else printf '%d.%dM' $((n / 1000000)) $(((n % 1000000) / 100000)); fi
}

# --- Line 1: 200k dot, model, effort, dir, git branch, lines changed ---
if [ "$EXCEEDS_200K" = "true" ]; then DOT="${YELLOW}●${RESET}"; else DOT="${GREEN}●${RESET}"; fi
LINE1="${DOT} [$MODEL]"
[ -n "$EFFORT" ] && LINE1="${LINE1} ⚡ ${EFFORT}"
LINE1="${LINE1}  │  📂 ${DIR##*/}"

# Git branch + dirty marker, cached per-session to /tmp so we don't shell out to
# git on every render (the status line refreshes after each assistant message).
CACHE_FILE="/tmp/claude-statusline-git-${SESSION_ID:-nosess}"
cache_is_stale() {
    [ ! -f "$CACHE_FILE" ] || \
    [ $(( $(date +%s) - $(stat -c %Y "$CACHE_FILE" 2>/dev/null || stat -f %m "$CACHE_FILE" 2>/dev/null || echo 0) )) -gt 5 ]
}
if cache_is_stale; then
    if git -C "$DIR" rev-parse --git-dir >/dev/null 2>&1; then
        BRANCH=$(git -C "$DIR" branch --show-current 2>/dev/null)
        [ -n "$(git -C "$DIR" status --porcelain 2>/dev/null)" ] && BRANCH="${BRANCH}*"
        echo "$BRANCH" > "$CACHE_FILE"
    else
        echo "" > "$CACHE_FILE"
    fi
fi
GIT_INFO=$(cat "$CACHE_FILE" 2>/dev/null)
[ -n "$GIT_INFO" ] && LINE1="${LINE1}  🌿 ${GIT_INFO}"

# Lines changed sit next to the folder/branch on line 1
if [ "$LINES_ADDED" -gt 0 ] || [ "$LINES_REMOVED" -gt 0 ]; then
    LINE1="${LINE1}  ${GREEN}+${LINES_ADDED}${RESET} ${RED}-${LINES_REMOVED}${RESET}"
fi

# --- Line 2: context bar, cost, duration, tokens ---
BAR_COLOR=$(pct_color "$CONTEXT_PCT")
FILLED=$((CONTEXT_PCT / 10)); [ "$FILLED" -gt 10 ] && FILLED=10; [ "$FILLED" -lt 0 ] && FILLED=0
EMPTY=$((10 - FILLED))
printf -v FILL "%${FILLED}s"; printf -v PAD "%${EMPTY}s"
BAR="${FILL// /█}${PAD// /░}"
COST_FMT=$(printf '$%.2f' "$COST")
DURATION_FMT=$(fmt_duration "$DURATION_MS")
TOKENS_FMT=$(fmt_tokens "$TOTAL_TOKENS")
LINE2="${BAR_COLOR}${BAR}${RESET} ${CONTEXT_PCT}%  🤑 ${COST_FMT}  ⌚ ${DURATION_FMT}  🎫 ${TOKENS_FMT}"

# --- Line 3: rate limits (only if present) ---
build_rate_segment() {
    local label=$1 pct=$2 reset=$3
    [ -z "$pct" ] && return
    local pct_int=$(printf '%.0f' "$pct")
    local color=$(pct_color "$pct_int")
    local seg="${label} ${color}${pct_int}%${RESET}"
    [ -n "$reset" ] && seg="${seg} (resets $(fmt_reset "$reset"))"
    echo "$seg"
}
FIVE_H=$(build_rate_segment "5h" "$FIVE_H_PCT" "$FIVE_H_RESET")
WEEK=$(build_rate_segment "7d" "$WEEK_PCT" "$WEEK_RESET")
WINDOWS="$FIVE_H"
[ -n "$WEEK" ] && WINDOWS="${WINDOWS:+$WINDOWS  }${WEEK}"
LINE3=""
[ -n "$WINDOWS" ] && LINE3="🔋 ${WINDOWS}"

echo -e "$LINE1"
echo -e "$LINE2"
[ -n "$LINE3" ] && echo -e "$LINE3"

exit 0
