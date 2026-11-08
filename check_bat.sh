#!/bin/sh

BAT_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_STATE=$(cat /sys/class/power_supply/BAT0/status)

if [[ ${BAT_LEVEL} -lt '15' ]] ; then
	if [ ${BAT_STATE} == "Discharging" ] ; then
		/run/current-system/sw/bin/notify-send --urgency critical "low bat plz charge"
	else
		/run/current-system/sw/bin/notify-send "self_bin/check_bat.sh bat charing"
	fi
fi
