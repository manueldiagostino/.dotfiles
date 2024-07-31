#!/bin/bash

case "$1" in
icon)
	if [[ $(cat /sys/class/net/w*/operstate) = "down" ]]; then
		echo " "
	else
		echo ""
	fi
	;;
name)
	nmcli -f NAME connection | head -2 | tail -1 | tr -d '\n'
	;;
*)
	echo ""
	;;
esac
