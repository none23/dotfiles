#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
xinput --disable SynPS/2\ Synaptics\ TouchPad &
xmodmap /home/$USER/.Xmodmap &
xset s off && xset -dpms && xset r rate 200 60 &
xrdb -merge /home/$USER/.Xresources && xrdb ~/.Xresources

# {{{ nvidia 
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96
# nvidia }}} 

compton -b 
export QT_QPA_PLATFORMTHEME='qt5ct'
unclutter -idle 1 &
xscreensaver -nosplash &
systemd-analyze plot > /tmp/current-boot-plot.svg &
exec awesome
