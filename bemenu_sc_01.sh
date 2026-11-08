#!/bin/sh

# Select action between:
#  - lock
#  - sleep (suspend)
#  - reboot
#  - shutdown
#  - kill processes

select=$(echo -e "Lock\nAuto-sleep on/off\nSleep\nReboot\nShutdown\nKill Processes\n" | \
	fuzzel --background=0f0f0fff --no-icons --text-color=607080ff --border-color=405070ff -d -p "Select action:")

if [ -z "$select" ] ; then
	echo "canceled"
	exit 0
fi

case "$select" in
	"Lock")
		hyprlock
		;;
	"Sleep")
		systemctl suspend
		;;
	"Reboot")
		systemctl reboot
		;;
	"Shutdown")
		systemctl poweroff
		;;
	"Kill Processes")
		ps aux | awk '{print $2, $11}' | \
		fuzzel --background=0f0f0fff --no-icons --text-color=607080ff --border-color=405070ff -d -p "kill:" | awk '{print $2}' | xargs kill
		;;
	"Auto-sleep on/off")
		if pgrep -x "hypridle" > /dev/null ; then
			pkill hypridle
			notify-send "hypridle" "disabled"
		else
			hypridle &
			notify-send "hypridle" "enabled"
		fi
		;;
	*)
		echo "Invalid selection"
		;;
esac
