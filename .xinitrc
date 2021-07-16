#!/bin/sh

# ~/.xinitrc
# no using of .xsession or .xprofile, which is sourced by /etc/*dm/Xsession
# i.e. by `*dm`, or slim session mode
# Executed by X (Run your window manager from here)
# startx, slim, etc.


## set mouse speed behaviour:
# fast:
# xset m 4 2
# normal:
  xset m 2 5
# slow:
# xset m 1 1

# other settings:
# xset m 20/10 4

# disable screensaver and dpms:
# xset s off
# xset -dpms

# execute all existing scripts
for f in ~/.xinitrc.d/* ; do
  "$f"
done


# Environment variables
export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8

## Gentoo: If you do not enable the gtk and gtk3 USE flags, use:
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim

# IME
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx
#export XMODIFIERS=@im=fcitx
# Some programs can only use xim, if you are using these programs, please make sure your XMODIFIERS is set properly and be aware of the problems you may have. These programs include all programs that are not using GTK or Qt (e.g. programs that use tk, motif, or xlib directly), emacs, opera, openoffice, libreoffice, 


##In GDM/KDM/LightDM/Slim (Session Mode)
## You should append the lines to ~/.xprofile (If not exists, create a new one).
## In Slim (~/.xinitrc)/startx
## You need to add those lines in your ~/.xinitrc.

#xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 16 -solid black
# set default cursor
xsetroot -cursor_name left_ptr
xsetroot -solid '#80a0af'

#xloadimage -onroot -fullscreen /$HOME/pix/Peppermint.jpg
#xloadimage -onroot -fullscreen /~/pix/Peppermint.jpg
#feh --bg-scale //Bilder/waves_sunset-1920x1200.jpg &
#xscreensaver -nosplash &
$(gnome-keyring-daemon --start --daemonize)

# xresources
# Moved $HOME/.Xresources to $XDG_CONFIG_HOME/xorg/xresources
#userresources=$HOME/.Xresources
userresources=$XDG_CONFIG_HOME/xorg/xresources
[ -r $userresources ] && xrdb -merge $userresources

##setxkbmap de nodeadkeys
# xmodmap -e "keycode 233 = Page_Down"
# xmodmap -e "keycode 234 = Page_Up"
# xmodmap -e "remove Lock = Caps_Lock"
# xmodmap -e "keysym Caps_Lock = Control_L"
# xmodmap -e "add Control = Control_L"

# merge in defaults and keymaps

# start some nice programs

##Note that if you need im module or kimpanel support, DBus must be initialized correctly.
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi


touch /tmp/$1

# IME
#fcitx &
sleep 2


### xrandr -s 0

# xset fp rehash
xset b 100 0 0
### xset r rate 140 200

### status | dzen2 -ta r -w 1200 -fg '#a8a3f7' -bg '#3f3c6d' -fn '-*-terminus-medium-r-normal--16-*' -e "button1=exec:xterm" &

# launch the external 60 second clock, and launch the workspace status bar
FG='#a8a3f7'
BG='#3f3c6d'
### xmonad-clock | dzen2 -e '' -x 400 -w 1200 -ta r -fg $FG -bg $BG &

xmonad

# wait for xmonad
### wait $!
### pkill -HUP dzen2
### wait

#DEFAULT_SESSION=xfce4-session
#DEFAULT_SESSION=startxfce4
#DEFAULT_SESSION=mate-session
#DEFAULT_SESSION=awesome
#DEFAULT_SESSION=i3
#DEFAULT_SESSION=xmonad-session
DEFAULT_SESSION=xmonad
case $1 in
  xfce) exec dbus-launch xfce4-session ;;
  dwm)
    #conky -qc /home/sunn/.xmonad/.conky_dzen | dzen2 -x '666' -w '700' -h '12' -ta 'r' -bg '#222222' -fg '#bbbbbb' -y '0' -fn '-*-lime-*-*-*-*-*-*-*-*-*-*-*-*' &
    #conky -qc /home/sunn/.xmonad/.conky_dzen | while read -r; do xsetroot -name "$REPLY"; done &
    exec dbus-launch dwm-launch
    ;;
  *)
    exec dbus-launch $DEFAULT_SESSION &
    #exec $DEFAULT_SESSION &&
	# Exec=/usr/bin/xmonad-start
    xmonad --replace
    #i3 --replace
    #awesome --replace
    #=gnome-flashback-xmonad
    #=i3-with-shmlog
    #=startlxqt
    ;;
    #bspwm|*)
    #sxhkd &
    #[ -e "$PANEL_FIFO" ] && rm "$PANEL_FIFO"
    #mkfifo "$PANEL_FIFO"
    #exec dbus-launch bspwm -c /home/sunn/.config/bspwm/autostart -s "$PANEL_FIFO" -p W
esac


# default entry
#exec /usr/bin/x-window-manager
#exec awesome

[ -f ~/.xprofile  ] && source ~/.xprofile


