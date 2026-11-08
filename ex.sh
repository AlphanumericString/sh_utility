#!/bin/sh

if [ -z "$1" ]; then
	echo "Usage: ex <file>"
	exit 1
fi

if [ -f "$1" ]; then
	file="$1"
else
	echo "File not found: $1"
	exit 1
fi

if [ -d "$file" ]; then
	echo "File is a directory: $file"
	exit 1
else
	case "$file" in
		*.tar.bz2) tar xvjf "$file" ;;
		*.tar.gz) tar xvzf "$file" ;;
		*.tar.xz) tar xvf "$file" ;;
		*.bz2) bunzip2 "$file" ;;
		*.rar) unrar x "$file" ;;
		*.gz) gunzip "$file" ;;
		*.tar) tar xvf "$file" ;;
		*.tbz2) tar xvjf "$file" ;;
		*.tgz) tar xvzf "$file" ;;
		*.zip) unzip "$file" ;;
		*.Z) uncompress "$file" ;;
		*.7z) 7z x "$file" ;;
		*) echo "Unknown file format" ;;
	esac
fi
