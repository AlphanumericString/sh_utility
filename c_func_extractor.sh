#!/bin/sh

dir="."
name="functions.h"

if [ $# -eq 2 ]; then
	dir="$1"
	name="$2"
elif [ $# -eq 1 ]; then
	dir="$1"
else
	echo "Usage: $0 [directory] [output file]"
	exit 1
fi

if [ ! -d "$dir" ]; then
	echo "Error: $dir is not a directory"
	exit 1
fi

if [ "$name" = "functions.h" ]; then
	if [ -f "$dir/Makefile" ]; then
		name=$(rg '^NAME' "$dir/Makefile" | awk '{print $3}').h
	else
		echo "Warning: No Makefile found, using default name functions.h"
	fi
fi

echo "Extracting C functions from $dir to $name"

if [ -f "$name" ]; then
	printf "Warning: %s already exists, overwrite? [Yn]" "$name"
	read -r user_rep
	if [ "$user_rep" = "n" ] || [ "$user_rep" = "N" ]; then
		echo "Okay bye :D"
		exit 0
	fi
fi

name_guards=$(echo "$name" | tr '[:lower:]' '[:upper:]' | tr '.' '_')
echo "#ifndef $name_guards" > "$name"
echo "# define $name_guards" >> "$name"
echo "Extracting functions from $dir to $name"

find "$dir" -name "*.c" | while IFS= read -r file; do
	echo "Extracting functions from $file"
	awk '
	BEGIN {
		in_f_dcl = 0;
		param_name = "";
	}
	(in_f_dcl && /.*\)/) {
		in_f_dcl = 0;
		print f_dcl " " $0 ";";
	} (in_f_dcl) {
		f_dcl = f_dcl " " $0;
	} (!in_f_dcl && /^[a-zA-Z_].*/ && /.*\)/ && !/^static.*/) {
		print $0 ";";
	}' "$file" | while IFS= read -r func; do
		func_name=$(printf '%s\n' "$func" | awk -v FS=' ' '{
			for (n=0 ; n < NF ; n++)
			{
				if (match($(n+1), /\(/))
				{
					print $(n+1)
					break
				}
			}
		}' | tr '*);,' ' ' | awk '{print $1}' | sed 's/(.*//g')
		echo "/// @brief $func_name" >> "$name"
		params=$(printf '%s\n' "$func" | awk -v FS=' ' '{
			for (n = 0 ; n < NF ; n++) {
				if (match ($(n+1), /\(void/)) {
					continue;
				}
				if (match ($(n+1), /[a-zA-Z0-9]*[{,}{\);}]/)) {
					print $(n + 1) ;
				}
			}
		}' | tr '*);,' ' ' | awk '{print $1}')
		for param in $params; do
			if [ -z "$param" ]; then
				continue
			fi
			echo "/// @param $param" >> "$name"
		done
		echo "/// @file: $file" >> "$name"
		printf '%s\n\n' "$func" >> "$name"
	done
done

echo "" >> "$name"
echo "#endif /* $name_guards */" >> "$name"
