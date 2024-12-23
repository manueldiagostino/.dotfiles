#!/bin/bash

swayidle -w \
	timeout 300 '~/.config/hypr/lock.sh' \
	timeout 600 '
        hyprctl dispatch dpms off eDP-1
        hyprctl monitors | grep HDMI
        ret=$?

        if [ $ret -eq 0 ]	
        then
          hyprctl dispatch dpms off DP-1
        fi

        systemctl suspend' \
	resume '
        hyprctl dispatch dpms on eDP-1
        hyprctl monitors | grep HDMI
        ret=$?

        if [ $ret -eq 0 ]	
        then
          hyprctl dispatch dpms on DP-1
        fi
        ' \
	before-sleep '~/.config/hypr/lock.sh' \
	lock '~/.config/hypr/lock.sh'
