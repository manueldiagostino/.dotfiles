#!/bin/bash
currVolume=$(pactl get-sink-volume 0 | awk '{print $5}' | tr -d '%')
currMic=$(pactl get-source-volume 0 | awk '{print $5}' | tr -d '%')

case "$1" in
get-volume)
	echo $currVolume
	exit
	;;
get-mic)
	echo $currMic
	exit
	;;
esac

volumeLockFile=$HOME/.cache/volume.lock
micLockFile=$HOME/.cache/mic.lock

case "$1" in
set-volume)
	pactl set-sink-volume 0 "$2%"

	if [[ $2 -ne 0 ]]; then
		echo "" >$volumeLockFile
	else
		echo "" >$volumeLockFile
	fi
	;;
set-mic)
	pactl set-source-volume 0 "$2%"

	if [[ $2 -ne 0 ]]; then
		echo "" >$micLockFile
	else
		echo "" >$micLockFile
	fi
	;;
*)
	exit
	;;
esac
