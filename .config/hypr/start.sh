#!/usr/bin/sh

sleep 1
killall xdg-desktop-portal-hyprland
killall xdg-desktop-portal-wlr
killall xdg-desktop-portal-kde
killall xdg-desktop-portal
/usr/lib/xdg-desktop-portal &

sleep 2
/usr/lib/xdg-desktop-portal-hyprland &

sleep 1
killall xdg-desktop-portal-kde

bash -c "/home/manuel/.config/hypr/handle_monitor_connection.sh" &

exit 0
