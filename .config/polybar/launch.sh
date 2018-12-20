#!/bin/bash

IPC_SEARCH=/tmp/polybar_mqueue_search
WINDOW_ID_SEARCH=/tmp/window_id_search

IPC_ROFI=/tmp/polybar_mqueue_rofi
WINDOW_ID_ROFI=/tmp/window_id_rofi

IPC_OPTIONS=/tmp/polybar_mqueue_options
WINDOW_ID_OPTIONS=/tmp/window_id_options

WINDOW_ID_CONKY=/tmp/conky_window_id

create_bar() {
    polybar $1 &
    BAR_ID=$!
    echo PID = $BAR_ID
    WIN_ID=$(xdotool search --sync --pid $BAR_ID)
    echo $WIN_ID > $2
    xdotool windowunmap $WIN_ID
}

animation_open() {
    for BAR_ID in $@; do
        xdotool windowmap $BAR_ID
    done
    for y in `seq -300 40 0`; do
        for BAR_ID in $@; do
            xdotool windowmove $BAR_ID x $y
        done
        sleep 0.001
    done
}

animation_close() {
    for y in `seq 0 -40 -300`; do
        for BAR_ID in $@; do
            xdotool windowmove $BAR_ID x $y
        done
    done
    for BAR_ID in $@; do
        xdotool windowunmap $BAR_ID
    done
}



conky_launch() {
    # Hacky X11 magic to make Conky appear above polybar
    killall conky
    # xdotool search can't find Conky's window but fortunately Conky outputs it
    conky -c .config/conky/config_alt 2> /tmp/conky_out
    # Extract the hex window id from Conky's output
    HEX=$(awk '/drawing to created window/ {print $NF}' /tmp/conky_out | tr -d '()' | awk -Fx '{print $2}')
    echo $HEX
    WIN_ID=$(( 16#$HEX )) # convert to decimal
    echo $WIN_ID
    xdotool windowunmap $WIN_ID
    echo $WIN_ID > $WINDOW_ID_CONKY
}

launch() {
    killall polybar
    # conky_launch
    # polybar full &
    for m in $(polybar --list-monitors | cut -d":" -f1); do
        MONITOR=$m polybar --reload full &
    	BAR_ID=$!
    	rm -f /tmp/polybar_mqueue_full
    	ln -s /tmp/polybar_mqueue.$BAR_ID /tmp/polybar_mqueue_full
    	# create_bar left     $WINDOW_ID_SEARCH  &
    	# sleep 0.2
    	# create_bar center   $WINDOW_ID_ROFI    &
    	# sleep 0.2
    	# create_bar right    $WINDOW_ID_OPTIONS &
    done
}

rofi_open() {
    BAR_ID=$(cat $WINDOW_ID_ROFI)
    # animation_open $BAR_ID
    rofi -show run -location 2
    # animation_close $BAR_ID
}

search_open() {
    BAR_ID=$(cat $WINDOW_ID_SEARCH)
    # animation_open $BAR_ID
    rofi -show window -location 1 -width 28
    # animation_close $BAR_ID
}

menu_options() {
	echo -e "\tSleep"
	echo -e "\tShutdown"
	echo -e "\tLock"
        echo -e "\tScreenshot"
	echo -e "\tBack"
}

menu_selection() {
	case "$2" in
	Lock)
			i3lock -i ~/Pictures/lock.png
			;;
        Shutdown)
            systemctl poweroff
            ;;
        Screenshot)
            exec scrot -e 'feh $f -x' --delay 1 &
            ;;
	Sleep)
	   i3lock -i ~/Pictures/lock.png && systemctl suspend
	esac
}

options_open() {
    ID_CONKY=$(cat $WINDOW_ID_CONKY)
    ID_BAR=$(cat $WINDOW_ID_OPTIONS)

    # xdotool windowraise $ID_CONKY
    # animation_open $ID_BAR $ID_CONKY
    selection=$(menu_options | rofi -dmenu -i -p "" -location 3 -width 10 -line-margin 10 -lines 6)
    menu_selection $selection
    # animation_close $ID_BAR $ID_CONKY
}

case "$1" in
    rofi)
        rofi_open;;
    search)
        search_open;;
    options)
        options_open;;
    launch)
        launch;;
    hide)
        echo "cmd:hide" >> /tmp/polybar_mqueue_full;;
    show)
        echo "cmd:show" >> /tmp/polybar_mqueue_full;;
esac
