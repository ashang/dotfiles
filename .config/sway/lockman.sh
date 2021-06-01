#!/bin/sh
# Times screen off and puts it to bg
swayidle timeout 10 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"' &
swaylock -c 550000
# Kills last bg task so idle timer doesn't keep running
kill %%

