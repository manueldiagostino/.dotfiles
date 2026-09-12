#!/bin/bash

# Arguments: -v for vertical, -h for horizontal
DIRECTION=$1

# 1. Get current window index
CUR_IDX=$(tmux display-message -p '#I')

# 2. Get list of other windows
OTHER_WINS=$(tmux list-windows -F '#I: #W' | grep -v "^$CUR_IDX:")
WIN_COUNT=$(echo "$OTHER_WINS" | grep -c .)

# Exit if no other windows exist
if [ "$WIN_COUNT" -eq 0 ]; then
	exit 0
fi

# 3. Select Window
if [ "$WIN_COUNT" -eq 1 ]; then
	TARGET_WIN="$OTHER_WINS"
else
	TARGET_WIN=$(echo "$OTHER_WINS" | fzf-tmux -p 80%,70% --no-sort --border-label " Select Window ")
fi

[ -z "$TARGET_WIN" ] && exit 0
WIN_ID=$(echo "$TARGET_WIN" | cut -d: -f1)

# 4. Select Pane
PANE_COUNT=$(tmux list-panes -t "$WIN_ID" | wc -l)

if [ "$PANE_COUNT" -eq 1 ]; then
	PANE_ID="0"
else
	TARGET_PANE=$(tmux list-panes -t "$WIN_ID" -F '#P: #{pane_current_command}' | fzf-tmux -p 70%,60% --no-sort --border-label " Select Pane ")
	[ -z "$TARGET_PANE" ] && exit 0
	PANE_ID=$(echo "$TARGET_PANE" | cut -d: -f1)
fi

# 5. Execute Join
tmux join-pane "$DIRECTION" -s "$WIN_ID.$PANE_ID"
