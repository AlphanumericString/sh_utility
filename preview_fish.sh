#!/bin/sh

mime=$(file --mime -Lb "$1")

case "$mime" in
	text/*)
		bat --style=numbers --color=always "$1"
		;;
	image/*)
		kitten icat "$1"
		;;
	inode/directory\;*)
		erd -L 2 --dirs-only --hidden --no-git -i -I "$1" \
			2> /dev/null || echo "Directory: $1 has no subdirectories"
		;;
	application/pdf\;*)
		pdfinfo "$1"
		;;
	application/zip\;*)
		unzip -l "$1"
		;;
	*)
		echo "No preview available for type: $mime"
		;;
esac
