#!/bin/bash

./bar/scripts/workspaces.sh write-json

sleep 5

eww open bar --screen 0 -c ~/.config/eww/bar/

if [[ $(hyprctl monitors -j | jq '.[] | select(.name == "DP-2") | .dpmsStatus') == "true" ]]; then
	eww open bar --screen 1 -c ~/.config/eww/bar/
fi
