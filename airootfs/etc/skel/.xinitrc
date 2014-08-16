xsetroot -cursor_name left_ptr &
ROOTSZ=$(xwininfo -root|grep geometry|grep -Po \\d+x\\d+)
ROOTW=$(echo $ROOTSZ|cut -d x -f 1)
ROOTH=$(echo $ROOTSZ|cut -d x -f 2)
SETDIR=~/.config/dwb
SETFILE=$SETDIR/settings
echo "default-width=$ROOTW">>$SETFILE
echo "default-height=$ROOTH">>$SETFILE
tilda &
while true;do dwb -S;done
