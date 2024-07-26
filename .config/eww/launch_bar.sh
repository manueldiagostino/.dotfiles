#!/bin/bash

./bar/scripts/workspaces.sh write-json

sleep 5

eww open bar --screen 0 --id primary -c ~/.config/eww/bar/

if [[ $(hyprctl monitors -j | jq '.[] | select(.name == "DP-1") | .dpmsStatus') == "true" ]]; then
	eww open bar --screen 1 --id secondary -c ~/.config/eww/bar/
fi
