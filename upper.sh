#!/bin/sh

input="$1"

if [ -z "$input" ]; then
	tr '[:lower:]' '[:upper:]'
else
	echo "$input" | tr '[:lower:]' '[:upper:]'
fi
