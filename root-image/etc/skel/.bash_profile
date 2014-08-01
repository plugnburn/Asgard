sudo mount / -o remount,rw
amixer sset Master unmute
[[ -z $DISPLAY  ]] && exec startx
