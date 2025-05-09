#!/bin/bash

# for testing
#exec >>/tmp/script.log 2>&1
#set -xu

# export enviroment variables to be able to work with displays
export XAUTHORITY=/home/dastarikov/.Xauthority
export DISPLAY=:0.0

statusHDMI="$(xrandr | grep "HDMI-A-0")"

if [[ "${statusHDMI}" == *" connected"* ]]; then
    xrandr --output HDMI-A-0 --primary --mode 1920x1080 --left-of eDP \
	   --output eDP --off 
fi

if [[ "${statusHDMI}" == *" disconnected"* ]]; then
    xrandr --output HDMI-A-0 --off --output eDP --mode 1920x1200 --primary 
fi

   
