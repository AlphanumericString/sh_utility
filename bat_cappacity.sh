#!/bin/sh

battery=$(cat /sys/class/power_supply/BAT0/capacity)
b_status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$b_status" = "Charging" ]; then
	col="blue"
elif [ "$battery" -lt 30 ]; then
	col="orange"
elif [ "$battery" -lt 20 ]; then
	col="yellow"
elif [ "$battery" -lt 15 ]; then
	col="red"
else
	col="green"
fi

battery="$battery%"

if [ "$b_status" = "Charging" ]; then
	battery="$battery ⚡"
else
	battery="$battery"
fi

echo "$col"
echo "$battery"
