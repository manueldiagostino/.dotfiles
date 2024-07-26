#!/bin/bash

# Funzione per convertire un valore dalla scala 0-7500 alla scala 0-100
convert_to_percentage() {
	local value=$1
	if [[ ${value} -lt 0 || ${value} -gt 7500 ]]; then
		return 1
	fi

	# Calcolo del valore convertito
	local converted_value=$(echo "scale=2; ($value / 7500) * 100" | bc)
	# local converted_value=$(echo "scale=0; ($converted_value / 1)" | bc)
	echo $converted_value
}

case "$1" in
get)
	brightness_value=$(brightnessctl g)
	converted_value=$(convert_to_percentage $brightness_value)

	echo "$converted_value"
	;;
set)
	if [[ ! ${2} =~ ^[0-9]+$ || ${2} -lt 0 || ${2} -gt 100 ]]; then
		echo "Error [set]: '${2}' is not a valid number!"
		exit 1
	fi

	brightnessctl s "${2}%" 2>&1 1>/dev/null
	;;
*)
	echo default
	;;
esac
