#!/bin/bash
# changeBrightness

# Arbitrary but unique message tag
msgTag="mybrightnesss"

brightnessctl "$@" >/dev/null
brightness=$(brightnessctl g)
max_brightness=$(brightnessctl m)
brightness=$(awk "BEGIN { printf \"%.1f\", $brightness / $max_brightness * 100 }")

dunstify -a "changeBrightness" -u low -h string:x-dunst-stack-tag:$msgTag \
	-h int:value:"$brightness" "Luminosità: ${brightness}%"
