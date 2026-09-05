#!/usr/bin/env dash

# Date
date=$(date "+%a %F %R")

# CPU temp
cpu=$(sensors | grep "Package" | cut -f 1-3,5 -d " ")

# Alsa master volume
volume=$(amixer get Master | grep "Right:" | cut -f 7,8 -d " ")

# Status bar
echo $volume "|" $cpu "|" $date
