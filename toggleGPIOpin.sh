#!/bin/sh

# check if the script is run by root
if [ "$(whoami)" != "root" ]; then
	echo "You must run this script as a root user." 2>&1
	exit 1
fi

# GPIO numbers should be from this list
# 0, 1, 4, 7, 8, 9, 10, 11, 14, 15, 17, 18, 21, 22, 23, 24, 25

# set GPIO pin according to argument, otherwise default to pin 4
GPIOPIN=${1:-4}

# set pause time according to argument, otherwise default to 1 sec
PAUSETIME=${2:-1}

# if the incorrect number of arguments were passed, echo verbose message
if [ $# -ne 2 ]
then
	echo -n "* Toggle GPIO pin $GPIOPIN: "
fi

# set GPIO direction
echo "$GPIOPIN" > /sys/class/gpio/export
echo "out" > /sys/class/gpio/gpio$GPIOPIN/direction

# set GPIO value HIGH
echo -n "ON "
echo "1" > /sys/class/gpio/gpio$GPIOPIN/value

# pause
sleep $PAUSETIME

# set GPIO value (LOW)
echo -n "-> OFF"
echo "0" > /sys/class/gpio/gpio$GPIOPIN/value

# cleanup
echo "$GPIOPIN" > /sys/class/gpio/unexport

# if the incorrect number of arguments were passed, then finish with a newline
if [ $# -ne 2 ]
then
	echo 
fi
