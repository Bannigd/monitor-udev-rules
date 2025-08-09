#!/bin/bash

# for testing
#exec >>/tmp/script.log 2>&1
#set -xu

# export enviroment variables to be able to work with displays
export XAUTHORITY=/home/dastarikov/.Xauthority
export DISPLAY=:0.0

# IFS -- internal field separator, so i can split two line into array
# after using setting it back 
OIFS=$IFS
IFS=$'\n'
active_outputs=($(xrandr | grep " connected"))
IFS=$OIFS

# first gets length of array, second -- cuts string by spaces, returns first element and compare agaings eDP
# so if eDP is the only connected enable it and disable all others
if [[ ${#active_outputs[@]} == 1 && $(cut -d' ' -f 1 <<< ${active_outputs[0]}) == "eDP" ]]; then
	echo good
	xrandr --output eDP --mode 1920x1200 --primary \
		--output HDMI-A-0 --off \
		--output DisplayPort-0 --off \
		--output DisplayPort-1 --off 
	exit 0
fi

# if there are 2 (or more) connected outputs enable all of them except eDP
for i in "${active_outputs[@]}"
do 
	echo $i
	output_name=$(cut -d' ' -f 1 <<< $i) 
	if [[ $output_name == "eDP" ]]; then
		echo skipping eDP
		continue
	fi
	echo setting output
	xrandr --output $output_name --auto \
	       --output eDP --off 

done

# if [[ "${status_monitor}" == *" connected"* ]]; then
#     xrandr --output HDMI-A-0 --primary --mode 1920x1080 --left-of eDP \
# 	   --output eDP --off 
# fi
#
# if [[ "${status_monitor}" == *" disconnected"* ]]; then
#     xrandr --output HDMI-A-0 --off --output eDP --mode 1920x1200 --primary 
# fi

   
