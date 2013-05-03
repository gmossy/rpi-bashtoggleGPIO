#!/bin/sh

# check if the script is run by root
if [ "$(whoami)" != "root" ]; then
	echo "You must run this script as a root user." 2>&1
	exit 1
fi

# loop through all valid GPIO pin numbers
for i in 0 1 4 7 8 9 10 11 14 15 17 18 21 22 23 24 25
do
	echo -n "* Toggle GPIO pin $i: "
	sleep 0.5
	sh toggleGPIOpin.sh $i 1
	sleep 1
	echo
done
