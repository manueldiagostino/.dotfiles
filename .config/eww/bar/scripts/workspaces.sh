#!/bin/bash

LOCK_FILE="$HOME/.cache/eww-workspaces.lock"

active-workspace() {
	echo $(hyprctl activeworkspace -j | jq '.id')
}

workspaces-number() {
	json=$(hyprctl workspaces -j)
	last_index=$(echo ${json} | jq length)
	((last_index--))

	last_workspace_json=$(echo ${json} | jq ".[${last_index}]")
	number=$(echo ${last_workspace_json} | jq '.id')
	echo ${number}
}

determine_class() {
	if [[ $1 -eq $(active-workspace) ]]; then
		echo "button-workspace-active"
	else
		echo "button-workspace"
	fi
}

workspaces-json() {
	max=$(workspaces-number)
	json="["

	for ((i = 1; i <= max; i++)); do
		class=$(determine_class $i)
		json+="{\"id\": $i, \"class\": \"$class\"}"

		if [ $i -lt $max ]; then
			json+=","
		fi
	done

	json+="]"
	echo ${json}
}

write-json() {
	file_dim=$(stat -c%s "$LOCK_FILE")
	max_dim=1048576

	if ((file_dim > max_dim)); then
		rm "$LOCK_FILE"
		echo "Removed!"
	fi

	if [[ ! -e $LOCK_FILE ]]; then
		echo $(workspaces-json) >$LOCK_FILE
	fi

	last_json=$(tail -n 1 $LOCK_FILE | jq)
	# echo ${last_json}
	actual_json=$(workspaces-json | jq)
	# echo ${actual_json}

	if [ "${last_json}" != "${actual_json}" ]; then
		echo ${actual_json} >>${LOCK_FILE}
		echo "Updated!"
	fi
}

case $1 in
active-workspace)
	active-workspace
	;;
workspaces-number)
	workspaces-number
	;;
workspaces-list)
	max=$(workspaces-number)
	json="["

	for ((i = 1; i <= max; i++)); do
		json+="$i"
		if [ $i -lt $max ]; then
			json+=","
		fi
	done

	json+="]"
	echo ${json}
	;;
workspace-class)
	class="color: "
	if [[ $(active-workspace) = ${2} ]]; then
		class+="red;"
	else
		class+="white;"
	fi

	echo ${class}
	;;
workspaces-json)
	workspaces-json
	;;
write-json)
	write-json
	;;
*)
	echo -e "Usage:\n\tworkspaces.sh (active-workspace|workspaces-number|workspaces-list|workspace-class|write-json)"
	;;
esac
