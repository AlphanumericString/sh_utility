#!/bin/sh

valgrind --leak-check=full --show-leak-kinds=all --track-fds=yes \
	--trace-children=yes --track-origins=yes --read-var-info=yes \
	--show-reachable=yes --undef-value-errors=yes -q "$@"
