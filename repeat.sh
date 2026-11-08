#!/bin/sh

number="$1"
shift
strings="$*"

if [ -z "$number" ] || [ -z "$strings" ]; then
	echo "Usage: repeat <number> <string>"
	exit 1
fi

if [ "$number" -lt 0 ]; then
	echo "Count must be greater than -1"
	exit 1
fi

if [ "$number" -eq 0 ]; then
	exit 0
fi

result=""
i=0
while [ "$i" -lt "$number" ]; do
	result="$result $strings"
	i=$((i + 1))
done

# Remove the trailing spaces
result=$(echo "$result" | sed 's/^ *//;s/ *$//')
echo "$result"
