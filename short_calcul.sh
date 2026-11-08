#!/bin/sh

# depends on : bc, echo, wofi, notify-send

H_FILE=${HOME}/.calc_hist
PROMT="type mathematical expression"

if [ ! -f $H_FILE ]; then
	touch $H_FILE
fi

expr=$(tail -n 10 $H_FILE | wofi -d -p "$PROMT")
if [ -z "$expr" ]; then
	exit 0
fi
res=$(echo "scale=2; $expr" | bc -l 2>/dev/null)
if [ $? -ne 0 ]; then
	notify-send "calc" "error in expression"
	exit 1
fi
echo "$expr = $res" >> $H_FILE
notify-send "calc" "$expr = $res"
