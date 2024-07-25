#!/bin/bash

bash -c "while true; do ./bar/scripts/workspaces.sh write-json; sleep 0.5; done" &

eww open bar --screen 1 --id secondary -c ~/.config/eww/bar/
eww open bar --screen 0 --id primary -c ~/.config/eww/bar/
