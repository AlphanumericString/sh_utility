#!/bin/sh

input="$1"

if [ -z "$input" ]; then
	tr '[:upper:]' '[:lower:]'
else
	echo "$input" | tr '[:upper:]' '[:lower:]'
fi
