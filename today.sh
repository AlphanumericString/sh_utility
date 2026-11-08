#!/bin/sh

#cal
echo $(date "+%T - %D (%:z) %A" | awk '{print $0 " -"}
	(/Monday/) {print "Lundi"}
	(/Tuesday/) {print "Mardi"}
	(/Wednesday/) {print "Mercredi"}
	(/Thursday/) {print "Jeudi"}
	(/Friday/) {print "vendredi"}
	(/Saturday/) {print "Samedi"}
	(/Sunday/) {print "Dimanche"}')

# add : weather infos w curl
