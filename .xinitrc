#!/bin/sh

# ~/.xinitrc
# no using of .xsession or .xprofile, which is sourced by /etc/*dm/Xsession
# i.e. by `*dm`, or slim session mode
# Executed by X (Run your window manager from here)
# startx, slim, etc.

# configuration: by default all scripts from ~/.xinitrc.d are executed,
# but it's possible to configure this through a configuration file
if [ -r "$HOME/.config/${distri}/xinitrc" ] ; then
  . "$HOME/.config/${distri}/xinitrc"
elif [ -r "$HOME/.config/grml/xinitrc" ] ; then
  . "$HOME/.config/grml/xinitrc"
fi

# execute all existing scripts
for f in ~/.xinitrc.d/* ; do
  "$f"
done

# default entry, use e.g. 'grml-x windowmanager' for changing or just adjust manually
#exec /usr/bin/x-window-manager

## END OF FILE #################################################################

# init dbus for im module
eval `dbus-launch --sh-syntax --exit-with-session`

export LC_ALL=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8

[ -f ~/.xprofile  ] && source ~/.xprofile

#exec awesome

##Note that if you need im module or kimpanel support, DBus must be initialized correctly.
if which dbus-launch >/dev/null && test -z "$DBUS_SESSION_BUS_ADDRESS"; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi


# Environment variables
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

## Gentoo: If you do not enable the gtk and gtk3 USE flags, use:
#export GTK_IM_MODULE=xim
#export QT_IM_MODULE=xim

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

##In GDM/KDM/LightDM/Slim (Session Mode)
## You should append the lines to ~/.xprofile (If not exists, create a new one).
## In Slim (~/.xinitrc)/startx
## You need to add those lines in your ~/.xinitrc.

#xsetroot -xcf /usr/share/icons/Adwaita/cursors/left_ptr 16 -solid black
xsetroot -cursor_name left_ptr
xsetroot -solid '#80a0af'

#xloadimage -onroot -fullscreen /$HOME/pix/Peppermint.jpg
#xloadimage -onroot -fullscreen /~/pix/Peppermint.jpg
#feh --bg-scale //Bilder/waves_sunset-1920x1200.jpg &
#xscreensaver -nosplash &
$(gnome-keyring-daemon --start --daemonize)


sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# Moved $HOME/.Xresources to $XDG_CONFIG_HOME/xorg/xresources
userresources=$XDG_CONFIG_HOME/xorg/xresources
usermodmap=$HOME/.Xmodmap
##setxkbmap de nodeadkeys
# xmodmap -e "keycode 233 = Page_Down"
# xmodmap -e "keycode 234 = Page_Up"
# xmodmap -e "remove Lock = Caps_Lock"
# xmodmap -e "keysym Caps_Lock = Control_L"
# xmodmap -e "add Control = Control_L"

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#exec herbstluftwm


#exec ck-launch-session mate-session
# If you have authorization problems (e.g. when mounting disks), try
#exec ck-launch-session dbus-launch mate-session

touch /tmp/$1

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
#!/bin/sh
