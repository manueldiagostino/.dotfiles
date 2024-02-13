#!/bin/sh

function handle() {
	if [[ ${1:0:12} == "monitoradded" ]]; then
        sleep 2

        LAPTOP_ID=$(hyprctl workspaces -j | jq -r '.[] | select(.monitor == "eDP-1") | .monitorID' | uniq)
        MONITOR_ID=$(hyprctl workspaces -j | jq -r '.[] | select(.monitor == "DP-1") | .monitorID' | uniq)
    
        hyprctl dispatch moveworkspacetomonitor "6 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "5 ${MONITOR_ID}"
        hyprctl dispatch moveworkspacetomonitor "4 ${MONITOR_ID}"
        hyprctl dispatch moveworkspacetomonitor "3 ${MONITOR_ID}"
        hyprctl dispatch moveworkspacetomonitor "2 ${MONITOR_ID}"
        hyprctl dispatch moveworkspacetomonitor "1 ${MONITOR_ID}"

		hyprctl dispatch workspace 1
	elif [[ ${1:0:14} == "monitorremoved" ]]; then
        sleep 2

        LAPTOP_ID=$(hyprctl workspaces -j | jq -r '.[] | select(.monitor == "eDP-1") | .monitorID' | uniq)
        # MONITOR_ID=$(hyprctl workspaces -j | jq -r '.[] | select(.monitor == "DP-1") | .monitorID' | uniq)
    
        hyprctl dispatch moveworkspacetomonitor "1 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "2 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "3 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "4 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "5 ${LAPTOP_ID}"
        hyprctl dispatch moveworkspacetomonitor "6 ${LAPTOP_ID}"

		hyprctl dispatch workspace 1
	fi
}

sleep 5

MONITOR_ID=$(hyprctl workspaces -j | jq -r '.[] | select(.monitor == "DP-1") | .monitorID' | uniq)
[ -n $MONITOR_ID ] && handle "monitoradded"

socat - UNIX-CONNECT:/tmp/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/.socket2.sock | \
	while read line; do handle $line; done
