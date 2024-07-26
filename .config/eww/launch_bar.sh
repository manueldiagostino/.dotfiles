#!/bin/bash

# bash -c "while true; do ./bar/scripts/workspaces.sh write-json; sleep 0.5; done" &

./bar/scripts/workspaces.sh write-json

eww open bar --screen 1 --id secondary -c ~/.config/eww/bar/ --debug
# eww open bar --screen 0 --id primary -c ~/.config/eww/bar/
