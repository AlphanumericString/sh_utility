#!/bin/sh

field="$1"
delimiter="$2"

if [ "$field" = "0" ]; then
	cat /dev/stdin
	exit 0
fi

if [ -z "$delimiter" ]; then
	delimiter=" "
fi

if [ -z "$field" ]; then
	echo "Usage: field <field> [<delimiter>]"
	exit 1
fi

awk -v field="$field" -v delimiter="$delimiter" '{print $field}' FS="$delimiter"
