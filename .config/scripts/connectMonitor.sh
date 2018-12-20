#!/bin/sh

#xrandr --output eDP-1 --mode 1366x768 --pos 1920x312 --output HDMI-1 --mode 1920x1080 --pos 0x0 --primary
#feh --bg-fill /home/chase/Pictures/wallpaper.jpg
#setxkbmap -option caps:escape 
#sleep .1
#i3-msg 'workspace --no-auto-back-and-forth 1'
#i3-msg move workspace to output HDMI-1
#i3-msg 'workspace --no-auto-back-and-forth 3'
#i3-msg move workspace to output HDMI-1
#i3-msg 'workspace --no-auto-back-and-forth 5'
#i3-msg move workspace to output HDMI-1
#i3-msg 'workspace --no-auto-back-and-forth 7'
#i3-msg move workspace to output HDMI-1
#i3-msg 'workspace --no-auto-back-and-forth 9'
#i3-msg move workspace to output HDMI-1
#i3-msg workspace back_and_forth

set -e

/usr/bin/setxkbmap -option caps:escape 

if xrandr | grep -q "HDMI-1 disconnected"; then
  /usr/bin/xrandr --output HDMI-1 --off --output eDP-1 --primary
  light -S 80
else
  /usr/bin/xrandr --output eDP-1 --mode 1920x1080 --pos 1920x0 --output HDMI-1 --mode 1920x1080 --pos 0x0 --primary
  light -S 100
  for i in {1..10}; do
    rem=$(($i % 2))
    if [ "$rem" -ne "0" ]; then
      /usr/bin/i3-msg "workspace --no-auto-back-and-forth $i"
      /usr/bin/i3-msg move workspace to output primary
    fi
  done
  /usr/bin/i3-msg workspace back_and_forth
fi

