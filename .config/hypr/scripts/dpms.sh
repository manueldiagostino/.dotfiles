#!/bin/sh

eDP1_DPMS_STATUS=$(hyprctl monitors -j | jq '.[] | select(.name == "eDP-1") | .dpmsStatus')
# echo $eDP1_DPMS_STATUS

if [ $eDP1_DPMS_STATUS == 'true' ]; then
	hyprctl dispatch dpms off eDP-1
else
	hyprctl dispatch dpms on eDP-1
fi
