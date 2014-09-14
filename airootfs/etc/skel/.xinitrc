sudo mount / -o remount,rw
amixer sset Master unmute
xsetroot -cursor_name left_ptr &
ROOTSZ=$(xwininfo -root|grep geometry|grep -Po \\d+x\\d+)
ROOTW=$(echo $ROOTSZ|cut -d x -f 1)
ROOTH=$(echo $ROOTSZ|cut -d x -f 2)
SETDIR=~/.config/dwb
SETFILE=$SETDIR/settings
TILDACONF=~/.config/tilda/config_0
echo "default-width=$ROOTW">>$SETFILE
echo "default-height=$ROOTH">>$SETFILE
echo "max_width = $ROOTW">>$TILDACONF
echo "max_height = $ROOTH">>$TILDACONF
tilda &
while true;do dwb -S;done
