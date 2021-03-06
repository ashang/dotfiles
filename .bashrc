# ~/.bashrc: executed by bash(1) for non-login interactive shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in profile.

# ~/.bash_profile is sourced by BASH for login shells
# ~/.profile is *NOT* read by BASH IF ~/.bash_profile or ~/.bash_login exists
# ~/.profile should be executed by command interpreter (also /bin/sh ) for LOGIN shells

# In "su -", or "mintty -", the "-" is for --login, better to use `--login`

# Refer also to /etc/skel/
# Refer also to /etc/default

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# some ... shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# bash only
# Shell is non-interactive. Be done now!
#[[ $- != *i* ]] && return
#if [ -z "${-##*i*}" ]; then
case $- in
    *i*) ;;
      *) return;;
esac

# ~/.profile: executed by Bourne-compatible command interpreter for LOGIN shells
#~/.profile is *NOT* read by bash IF ~/.bash_profile or ~/.bash_login exists
# NOTE that other shells might also read it.

# TODO
# dpkg -s base-files | grep Description: -A50
# Description: Debian base system miscellaneous files
# This package contains the basic filesystem hierarchy of a Debian system, and
# several important miscellaneous files, such as /etc/debian_version,
# /etc/host.conf, /etc/issue, /etc/motd, /etc/profile, and others,
# and the text of several common licenses in use on Debian systems.
# dpkg -L base-files | grep profile$

# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022
#[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && . $HOME/.autojump/etc/profile.d/autojump.sh

#if [ "${PS1-}" ]; then

# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "$(dircolors)"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
# ~/.profile: executed by Bourne-compatible login shells.

mesg n 2> /dev/null || true


#QUOTE BEGIN
    ## System-wide .profile for sh(1)

    #if [ -x /usr/libexec/path_helper ]; then
        #eval `/usr/libexec/path_helper -s`
    #fi

    #if [ "${BASH-no}" != "no" ]; then
        #[ -r /etc/bashrc ] && . /etc/bashrc
    #fi
#QUOTE END

# Check which shell is reading this file
# check if variables are read-only before setting them
# for example in a restricted shell
if unset noprofile 2>/dev/null ; then
  noprofile=false
fi
if unset restricted 2>/dev/null ; then
  restricted=false
fi
: ${_is_save:=unset}
if test -z "$is" ; then
   if test -f /proc/mounts ; then
      if ! is=$(readlink /proc/$$/exe 2>/dev/null) ; then
          case "$0" in
              *pcksh)    is=ksh    ;;
              *bash)    is=bash    ;;
              *)        is=sh    ;;
          esac
      fi
      case "$is" in
          */bash)    is=bash
              while read -r -d $'\0' a ; do
                  case "$a" in
                      --noprofile)
                          readonly noprofile=true ;;
                      --restricted)
                          readonly restricted=true ;;
                  esac
              done < /proc/$$/cmdline
              case "$0" in
                  sh|-sh|*/sh)
                      is=sh    ;;
              esac        ;;
          */dash)    is=ash  ;;
          */mksh)    is=ksh  ;;
          */*pcksh)    is=ksh  ;;
          */zsh)    is=zsh  ;;
          */*)    is=sh   ;;
      esac
  #
  # `r' in $- occurs *after* system files are parsed
  #
  for a in $SHELL ; do
    case "$a" in
      */r*sh)
        readonly restricted=true ;;
      -r*|-[!-]r*|-[!-][!-]r*)
        readonly restricted=true ;;
      --restricted)
        readonly restricted=true ;;
    esac
  done
  unset a
 else
  is=sh
 fi
fi

#
# Call common progams from /bin or /usr/bin only
#
path ()
{
    if test -x /usr/bin/$1 ; then
    ${1+"/usr/bin/$@"}
    elif test -x   /bin/$1 ; then
    ${1+"/bin/$@"}
    fi
}

# Set prompt and aliases to something useful for an interactive shell
case "$-" in
*i*)
    # Set prompt to something useful
    case "$is" in
        bash)
        # If COLUMNS are within the environment the shell should update
        # the winsize after each job otherwise the values are wrong
        case "$(declare -p COLUMNS 2> /dev/null)" in
            *-x*COLUMNS=*) shopt -s checkwinsize
        esac

        # All commands of root will have a time stamp
        if test "$UID" -eq 0  ; then
            HISTTIMEFORMAT=${HISTTIMEFORMAT:-"%F %H:%M:%S "}
        fi
        # Force a reset of the readline library
        unset TERMCAP

    # Returns short path (last two directories)
    spwd () {
      ( IFS=/
        set $PWD
        if test $# -le 3 ; then
        echo "$PWD"
        else
        eval echo \"..\${$(($#-1))}/\${$#}\"
        fi ) ; }

    # Set xterm prompt with short path (last 18 characters)
    if path tput hs 2>/dev/null || path tput -T $TERM+sl hs 2>/dev/null ; then
        # Mirror prompt in terminal "status line", which for graphical
        # terminals usually is the window title. KDE konsole in
        # addition needs to have "%w" in the "tabs" setting, ymmv for
        # other console emulators.
        if [[ $TERM = *xterm* ]] ; then
        _tsl=$(echo -en '\e]2;')
        _isl=$(echo -en '\e]1;')
        _fsl=$(echo -en '\007')
        elif path tput -T $TERM+sl tsl 2>/dev/null ; then
        _tsl=$(path tput -T $TERM+sl tsl 2>/dev/null)
        _isl=''
        _fsl=$(path tput -T $TERM+sl fsl 2>/dev/null)
        else
        _tsl=$(path tput tsl 2>/dev/null)
        _isl=''
        _fsl=$(path tput fsl 2>/dev/null)
        fi
        _sc=$(tput sc 2>/dev/null)
        _rc=$(tput rc 2>/dev/null)
        if test -n "$_tsl" -a -n "$_isl" -a "$_fsl" ; then
        TS1="$_sc$_tsl%s@%s:%s$_fsl$_isl%s$_fsl$_rc"
        elif test -n "$_tsl" -a "$_fsl" ; then
        TS1="$_sc$_tsl%s@%s:%s$_fsl$_rc"
        fi
        unset _isl _tsl _fsl _sc _rc
        ppwd () {
        local dir
        local -i width
        test -n "$TS1" || return;
        dir="$(dirs +0)"
        let width=${#dir}-18
        test ${#dir} -le 18 || dir="...${dir#$(printf "%.*s" $width "$dir")}"
        if test ${#TS1} -gt 17 ; then
            printf "$TS1" "$USER" "$HOST" "$dir" "$HOST"
        else
            printf "$TS1" "$USER" "$HOST" "$dir"
        fi
        }
    else
        ppwd () { true; }
    fi

    # If set: do not follow sym links
    # set -P
    # Other prompting for root
    if test "$UID" -eq 0  ; then
        if test -n "$TERM" -a -t ; then
            _bred="$(path tput bold 2> /dev/null; path tput setaf 1 2> /dev/null)"
            _sgr0="$(path tput sgr0 2> /dev/null)"
        fi
        # Colored root prompt (see bugzilla #144620)
        if test -n "$_bred" -a -n "$_sgr0" ; then
        _u="\[$_bred\]\h"
        _p=" #\[$_sgr0\]"
        else
        _u="\h"
        _p=" #"
        fi
        unset _bred _sgr0
    else
        _u="\u@\h"
        _p=">"
    fi

    if test -z "$EMACS" -a -z "$MC_SID" -a "$restricted" != true -a \
        -z "$STY" -a -n "$DISPLAY" -a ! -r $HOME/.bash.expert
    then
        _t="\[\$(ppwd)\]"
    else
        _t=""
    fi

    case "$(declare -p PS1 2> /dev/null)" in
    *-x*PS1=*)
        ;;
    *)
        # With full path on prompt
        PS1="${_t}${_u}:\w${_p} "
#        # With short path on prompt
#        PS1="${_t}${_u}:\$(spwd)${_p} "
#        # With physical path even if reached over sym link
#        PS1="${_t}${_u}:\$(pwd -P)${_p} "
        ;;
    esac

    unset _u _p _t
    ;;
    ash)
    cd () {
        local ret
        command cd "$@"
        ret=$?
        PWD=$(pwd)
        if test "$UID" = 0 ; then
        PS1="${HOST}:${PWD} # "
        else
        PS1="${USER}@${HOST}:${PWD}> "
        fi
        return $ret
    }
    cd .
    ;;
    *)
        PS1="${USER}@${HOST}:"'${PWD}'"> "
    ;;
    esac
    PS2='> '
    PS4='+ '

    case "$BASH_VERSION" in
    [2-9].*)
        if test -s /etc/profile.d/bash_completion.sh ; then
        . /etc/profile.d/bash_completion.sh
        fi
        # Do not source twice if already handled by bash-completion
        if [[ -n $BASH_COMPLETION_COMPAT_DIR && $BASH_COMPLETION_COMPAT_DIR != /etc/bash_completion.d ]]; then
        for s in /etc/bash_completion.d/*.sh ; do
            test -r $s && . $s
        done
        fi
        if test -e $HOME/.bash_completion.d ; then
        for s in $HOME/.bash_completion.d/* ; do
            test -r $s && . $s
        done
        fi
        ;;
    *)  ;;
    esac

        case $(set -o) in
            *multiline*) set -o multiline
        esac
    ;;
esac

#/etc/profile.d/vte-2.91.sh
# It is vte.sh's responsibility to 'not load' when it's not applicable (not inside a VTE term)
# If you want to 'disable' this functionality, set the sticky bit on /etc/profile.d/vte.sh
if test -r /etc/profile.d/vte.sh -a ! -k /etc/profile.d/vte.sh; then
  . /etc/profile.d/vte.sh
fi

if test "$_is_save" = "unset" ; then
    #
    # Just in case the user excutes a command with ssh or sudo
    #
    if test \( -n "$SSH_CONNECTION" -o -n "$SUDO_COMMAND" \) -a -z "$PROFILEREAD" -a "$noprofile" != true ; then
    _is_save="$is"
    _SOURCED_FOR_SSH=true
    . /etc/profile > /dev/null 2>&1
    unset _SOURCED_FOR_SSH
    is="$_is_save"
    _is_save=unset
    fi
fi

if test "$_is_save" = "unset" ; then
    unset is _is_save
fi

if test "$restricted" = true -a -z "$PROFILEREAD" ; then
    PATH=/usr/lib/restricted/bin
    export PATH
fi

unset color_prompt force_color_prompt

# For dircolors-solarized
# - https://github.com/seebi/dircolors-solarized

# for a colored prompt, if the terminal has the capability
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

if [[ "`uname -s`" == "FreeBSD" ]]
#if [[ "$OSTYPE" =~ *BSD ]]; then
then
  alias ls='ls -FG'
elif [[ "$OSTYPE" =~ ^darwin ]]; then
#elif [ "`uname -s`" == "Darwin" ]
    # uname also works
  alias ls="command ls -bFG"
else # Assume Linux
  #alias ls="command ls -FG"
  alias ls='ls -F -G -X -C -h --color=auto --show-control-chars'
  #alias ls='\ls -F -X --color=tty --show-control-chars'
fi

########################################
# colorful


#Color scheme
# 033 = e

# BLACK       0;30     DARK_GRAY     1;30
# BLUE        0;34     LIGHT_BLUE    1;34
# GREEN       0;32     LIGHT_GREEN   1;32
# CYAN        0;36     LIGHT_CYAN    1;36
# RED         0;31     LIGHT_RED     1;31
# PURPLE      0;35     LIGHT_PURPLE  1;35
# BROWN       0;33     YELLOW        1;33
# LIGHT_GRAY  0;37     WHITE         1;37

#the list above is for colours at the console.
#In xterm, 1;31 isn't "Light Red," but "Bold Red." This is true of all the colours.
#Combinations can be used, like Light Red on Blue background: \[\033[44;1;31m\],
#setting colours separately seems better (ie. \[\033[44m\]\[\033[1;31m\])
#Other codes available include 4: Underscore, 5: Blink, 7: Inverse, and 8: Concealed.

## for color and non-color terminals, as well as shells that don't
## understand sequences such as \h, don't put anything special in it.

# \u: current username
# \w: current working directory, \W: same, but only the basename
# \$: if the effective UID is 0: #, otherwise $
# \d: the date in "Weekday Month Date" format (e.g., "Tue May 26")
# \t: the current time in 24-hour HH:MM:SS format, \T: same, but 12-hour format, \@: same, but in 12-hour am/pm format
# \r: carriage return
# \\: backslash

# Colors & Styles
# colors have to be escaped (see General), color codes should be followed by an m
# put \[\e[‹code›m\] and \[\e[0m\] around the part of your prompt you want to style
# where ‹code› is a ;-chain of:
# x: attribute of the text
# 3y: foreground color
# 4y: background color
# x:
# 0: normal
# 1: bold
# 4: underline
# 7: reverse
# y is the color:
# 0 black
# 1 red
# 2 green
# 3 yellow
# 4 blue
# 5 magenta
# 6 cyan
# 7 white

# Regular Colors
Black='\e[0;30m'        # Black
RED="\[\e[01;31m\]"
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
MAGENTA='\e[0;35m'
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White
LIGHT_GRAY="\[\033[0;37m\]"

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

# unsets color to term's fg color
#NORMAL="\[\e[0m\]"
NORMAL="\[\e[m\]"

colors() {
  local fgc bgc vals seq0

  printf "Color escapes are %s\n" '\e[${value};...;${value}m'
  printf "Values 30..37 are \e[33mforeground colors\e[m\n"
  printf "Values 40..47 are \e[43mbackground colors\e[m\n"
  printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

  # foreground colors
  for fgc in {30..37}; do
    # background colors
    for bgc in {40..47}; do
      fgc=${fgc#37} # white
      bgc=${bgc#40} # black

      vals="${fgc:+$fgc;}${bgc}"
      vals=${vals%%;}

      seq0="${vals:+\e[${vals}m}"
      printf "  %-9s" "${seq0:-(default)}"
      printf " ${seq0}TEXT\e[m"
      printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
    done
    echo; echo
  done
}


export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
# for ls colors
LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
export LS_COLORS

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

use_color=false

safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

match_lhs=""
[[ -f $HOME/.dir_colors ]] && match_lhs="${match_lhs}$(<$HOME/.dir_colors)"
[[ -z ${match_lhs} ]] && type -P dircolors >/dev/null && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if type -P dircolors >/dev/null; then
# enable color support of ls, less and man, and also add handy aliases
    test -r ~/.dir_colors && eval "$(dircolors -b ~/.dir_colors)" || eval "$(dircolors -b)"
#Usage: dircolors [OPTION]... [FILE]
#Output commands to set the LS_COLORS environment variable.
#Determine format of output:
#  -b, --sh, --bourne-shell    output Bourne shell code to set LS_COLORS
#  -p, --print-database        output defaults
#If FILE is specified, read it to determine which colors to use for which file types and extensions.  Otherwise, a precompiled database is used.
#For details on the format of these files, run 'dircolors --print-database'.
    LS_COLORS=

    # If it isn't set, then `ls` will only colorize by default
    # based on file attributes and ignore extensions (even the compiled
    # in defaults of dircolors).

    if [[ -n ${LS_COLORS:+set} ]] ; then
        use_color=true
    else
        # Delete it if it's empty as it's useless in that case.
        unset LS_COLORS
    fi

else
    # Some systems (e.g. BSD & embedded) don't typically come with
    # dircolors so we need to hardcode some terminals in here.
    case ${TERM} in
        [aEkx]term*|tmux|screen|alacritty|kitty|*color)
            use_color=true
            ;;
    esac
fi


if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='ls --color=auto --format=vertical'
    #alias vdir='ls --color=auto --format=long'
fi

    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    # Never use 'grep --colour=always', control characters apply!
    alias grep='grep --color=auto --exclude-dir=.git -s -I'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#Shell Options
#See man bash for more options...

#Don't wait for job termination notification
set -o notify

#http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
[ "${BASH_VERSINFO}" -ge "4" ] && shopt -s autocd cdspell dirspell

# Use case-insensitive filename globbing
shopt -s nocaseglob

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

#$ tty
#/dev/ttys003
#$ uname -a
#Darwin Mato.local 14.0.0 Darwin Kernel Version 14.0.0: Fri Sep 19 00:26:44 PDT 2014; root:xnu-2782.1.97~2/RELEASE_X86_64 x86_64

# Bash won't get SIGWINCH if another process is in the foreground.
# Check terminal size when it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# how many ^D to exit
#set -o ignoreeof  # Same as setting IGNOREEOF=10
#set ignoreeof  # prevent accidental shell termination
# sometimes, stty eof '^D' / stty eof undef
#export IGNOREEOF=2
IGNOREEOF=2

# bind
# Bash is using readline to handle the prompt.
# $HOME/.inputrc is the configuration file for readline.
#After modify $HOME/.inputrc, use Ctrl+X, Ctrl+R to tell it to re-read $HOME/.inputrc.
## arrow up
#"\e[A": history-search-backward
## arrow down
#"\e[B": history-search-forward
#or equivalently,

# If bond, Some systems lacking of "" would mess HOME/END??
bind -r "\e[A"
bind -r "\e[B"
bind -r "\eOA"
bind -r "\eOB"
bind '"\e[A":history-search-backward'
bind '"\eOA":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\eOB":history-search-forward'

# To get the escape codes for the arrow keys you can do the following:
#Start cat in a terminal (just cat, no further arguments).
#Type keys on keyboard, you will get ^[[A for up arrow and ^[[B for down arrow.
#Replace ^[ with \e.
#bind "set match-hidden-files off"
bind "set bind-tty-special-chars on"  #punctuations are not word delimiters

#ctrl-RIGHT got 5C

# history
# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify

# Keep also space-starting lines, just in case
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# don't put duplicate lines or lines starting with space in the history.
#HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups:ignorespace

#Ignore some controlling instructions
#HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#The '&' is a special pattern which suppresses duplicate entries.
HISTIGNORE=$'[ \t]*:&:[fb]g:pwd:date:exit:ls'
#HISTIGNORE="[ \t]*:&:[fb]g:pwd:date:exit:* --help"

HISTIMEFORMAT="%F %T"

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=60000

#Whenever displaying the prompt, write the previous line to disk
# to keep history even after abnormal bash quit,

### history end

# Even for non-interactive, non-login shells.
# the default umask is set in /etc/profile
# The default umask is now handled by pam_umask.
# See pam_umask(8) and /etc/login.defs.

#/etc/profile sets 022, removing write perms to group + others.
#Set a more restrictive umask: i.e. no exec perms for others
#umask 027
##Paranoid: neither group nor others have any perms:
#umask 077
# if [ "`id -gn`" = "`id -un`" -a `id -u` -gt 99 ]; then
# id: cannot find name for group ID 1000
if [ $UID -gt 99 ] && [ "`id -gn`" = "`id -un`" ]; then
    umask 002
else
    umask 022
fi

# for ssh logins, install and configure the libpam-umask package

if ! shopt -q login_shell ; then # We're not a login shell
  # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
  pathmunge () {
    if ! echo $PATH | egrep -q "(^|:)$1($|:)" ; then
      if [ "$2" = "after" ] ; then
        PATH=$PATH:$1
      else
        PATH=$1:$PATH
      fi
    fi
  }

##FIXME time consuming
  for i in ~/etcfiles/profile.d/*.sh; do
    [ -r "$i" ] && . $i
  done
  unset i
  unset pathmunge
fi

function genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=20
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

function count {
  I=$1
  while [ $I -le $2 ];
    do echo $I
    I=$((I+1))
  done
}

function make() {
  pathpat="(/[^/]*)+:[0-9]+"
  ccred=$(echo -e "\033[0;31m")
  ccyellow=$(echo -e "\033[0;33m")
  ccend=$(echo -e "\033[0m")
  /usr/bin/make "$@" 2>&1 | sed -E -e "/[Ee]rror[: ]/ s%$pathpat%$ccred&$ccend%g" -e "/[Ww]arning[: ]/ s%$pathpat%$ccyellow&$ccend%g"
  return ${PIPESTATUS[0]}
}

function color() {
  tput setf $1
}
function nocolor() {
  tput sgr0
}
function sqd() {
  sqlite3 $1 .dump | less
}

function defaultps1() {
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\]\u@\h:\w\$ '
}
#defaultps1 # call it

TITLEBAR_PREFIX=""
function titlebar {
  TITLEBAR_PREFIX="$*"
  echo -ne "\033]2;$*\a"
}

# $(__git_ps1 "%s"): your current git branch if you're in a git directory, otherwise nothing
function __git_ps1() {
  if ! git root >/dev/null 2>&1; then
    return
  fi
  B=$(git curbr)
  U=$USER
  R=$(basename $(git root))
  H=$(hostname | cut -f1 -d.)
  W=$(realpath . | sed "s|$(git root)/\?|/|")

  #TODO: abstract the prefix, which sets titlebar and is duplicated
  TITLEBAR_PREFIX="$*"
  defaultps1
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\[$(color 6)\]$U@$H \[$(color 1)\]$R \[$(color 3)\]$B \[$(color 6)\]$W\[$(nocolor)\] \$ '
}

  PROMPT_COMMAND=__git_ps1
#PROMPT_COMMAND=bash_prompt_command

# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
# export PROMPT_COMMAND="history -a"
# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# #PROMPT_COMMAND='history -a $HOME/.bash_history; echo -ne "\033]0;$PWD\007"; $PROMPT_COMMAND;'

#if [ "`locale charmap 2>/dev/null`" = "UTF-8" ]
#then
  #stty iutf8
#fi

stty -ctlecho #don't show ^C when pressing Ctrl+C

## Timezone
TZ='Asia/Shanghai'; export TZ

# locale
# export LANGUAGE="zh_CN:zh:en"
#export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Dont clear the screen after quitting a manual page
export MANPAGER="less -X"

export LESSCHARSET=utf-8
#export LESS="-R"
alias less='less -R'                          # raw control characters
#alias less='less -r'                          # raw control characters

# test -r ~/.vim/branch_prompt.sh && source ~/.vim/branch_prompt.sh
# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

##bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
#if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs sh

unset -f have
unset RELEASE default dirnames filenames have nospace bashdefault plusdirs
set notildeop

#Functions

# implementation refs from https://github.com/jpetazzo/nsenter/blob/master/docker-enter
function docker-enter() {
    #if [ -e $(dirname "$0")/nsenter ]; then
    #Change for centos bash running
    if [ -e $(dirname '$0')/nsenter ]; then
        # with boot2docker, nsenter is not in the PATH but it is in the same folder
        NSENTER=$(dirname "$0")/nsenter
    else
        # if nsenter has already been installed with path notified, here will be clarified
        NSENTER=$(which nsenter)
        #NSENTER=nsenter
    fi
    [ -z "$NSENTER" ] && echo "WARN Cannot find nsenter" && return

    if [ -z "$1" ]; then
        echo "Usage: `basename "$0"` CONTAINER [COMMAND [ARG]...]"
        echo ""
        echo "Enters the Docker CONTAINER and executes the specified COMMAND."
        echo "If COMMAND is not specified, runs an interactive shell in CONTAINER."
    else
        PID=$(sudo docker inspect --format "{{.State.Pid}}" "$1")
        if [ -z "$PID" ]; then
            echo "WARN Cannot find the given container"
            return
        fi
        shift

        OPTS="--target $PID --mount --uts --ipc --net --pid"

        if [ -z "$1" ]; then
            # No command given.
            # Use su to clear all host environment variables except for TERM,
            # initialize the environment variables HOME, SHELL, USER, LOGNAME, PATH,
            # and start a login shell.
            #sudo $NSENTER "$OPTS" su - root
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid su - root
        else
            # Use env to clear all host environment variables.
            sudo $NSENTER --target $PID --mount --uts --ipc --net --pid env -i $@
        fi
    fi
}

function gum() { git checkout "$1" && git rebase master && git checkout master; }

# Show which branches need to be rebased on master, typically after a pull.
# commits listed between a branch and master. Then I know which branches to use with gum.
# The list of excluded branches includes branches which should not be rebased against master (I could do some processing of git branch -r to not have those hardcoded) but the odd one is stale. Sometimes, I get an idea for a feature which is too intrusive, too messy or just too incomplete to be rebased against master. Rather than losing the idea or wasting time rebasing, I'm getting into the habit of renaming the branch foo as stale-foo and gsb then leaves it alone. Equally, there are frequently times when I need to have a feature branch based on another feature branch, sometimes several feature branches deep. Identifying these branches and avoiding rebasing on the wrong branch is important to not waste time.
function gsb() { LIST=`git branch|egrep -v '(release|staging|trusty|playground|stale)'|tr '\n' ' '|tr -d '*'`; git show-branch $LIST; }

# Shows which feature branches can be dropped with git branch -d.
function gleaf(){ git branch --merged master | egrep -v '(release|staging|trusty|playground|pipeline|review|stale)'; }

function chd {
    local maxLength=100
    if [ -z $dirstack ] ; then
        dirstack=($PWD)
    fi
    builtin cd $@
    local length=${#dirstack[@]}
    local lastEntry=${dirstack[$length-1]}
    if [ $PWD != $lastEntry ]; then
        if [ $length -ge $maxLength ]; then
            dirstack=(${dirstack[@]:1})
            length=$(($length - 1))
        fi
        dirstack[$length]=$PWD
    fi
    return
}

# redefine 'cd' to push the current pwd to a stack before changing directory. 'cd--' is popping the stack and changing directory.
function cd-- {
    if [ -z $dirstack ] ; then
        dirstack=($PWD)
    fi
    local length=${#dirstack[@]}
    local folder=''
    while [ $length -gt 1 ] && [ ! -d "$folder" ]; do
        dirstack=(${dirstack[@]:0:$(($length - 1))})
        length=$(($length -1))
        folder=${dirstack[$length-1]}
        if [ $PWD == $folder ]; then folder=""; fi
    done
    if [ -d "$folder" ]; then
        builtin cd $folder
    else
        echo "Directory stack empty"
    fi
}

# cs .... and it will step 4 dir's up.
function cs () {
    DEPTH=$1
    for ((i=0; i< ${#DEPTH}; i++))
        do cd ..
    done;
}


# 'cd ..' will go back one dir
# 'cd ...' will go back two dirs
# function cd {
#     local maxLength=100
#     local lastArg=${!#}
#
#     if [ -z $dirstack ] ; then
#         dirstack=($PWD)
#     fi
#
#     if [ ! ${lastArg//[.]/} ] && [ ${#lastArg} -gt 2 ]; then
#       local CD=".."
#       for ((i=2; i < ${#lastArg}; i++)); do
#         CD="${CD}/.."
#       done;
#       builtin cd $CD
#     elif [ $lastArg == '-' ]; then
#       cd-
#     else
#       builtin cd $@
#     fi
#
#     local length=${#dirstack[@]}
#     local lastEntry=${dirstack[$length-1]}
#     if [ $PWD != $lastEntry ]; then
#         if [ $length -ge $maxLength ]; then
#             dirstack=(${dirstack[@]:1})
#             length=$(($length - 1))
#         fi
#         dirstack[$length]=$PWD
#     fi
#     return
# }




# 'cd -' or 'cd-' will use history
function cd- {
    if [ -z $dirstack ] ; then
        dirstack=($PWD)
    fi
    local length=${#dirstack[@]}
    local folder=''
    while [ $length -gt 1 ] && [ ! -d "$folder" ]; do
        dirstack=(${dirstack[@]:0:$(($length - 1))})
        length=$(($length -1))
        folder=${dirstack[$length-1]}
        if [ $PWD == $folder ]; then folder=""; fi
    done
    if [ -d "$folder" ]; then
        builtin cd $folder
    else
        echo "Directory stack empty"
    fi
}


#This function defines a 'cd' replacement function capable of keeping,
#displaying and accessing history of visited directories, up to 10 entries.
#To use it, uncomment it, source this file and try 'cd --'.
#acd_func 1.0.5, 10-nov-2004
function cd_func {
  local x2 the_new_dir adir index
  local -i cnt

##  if [[ $1 ==  "--" ]]; then dirs -v; return 0; fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

##  if [[ ${the_new_dir:0:1} == '-' ]]; then
##    #
##    # Extract dir N from dirs
##    index=${the_new_dir:1}
##    [[ -z $index ]] and index=1
##    adir=$(dirs +$index)
##    [[ -z $adir ]] and return 1
##    the_new_dir=$adir
##  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
##  for ((cnt=1; cnt <= 10; cnt++)); do
##    x2=$(dirs +${cnt} 2>/dev/null)
##    [[ $? -ne 0 ]] and return 0
##    [[ ${x2:0:1} == '~' ]] and x2="${HOME}${x2:1}"
##    if [[ "${x2}" == "${the_new_dir}" ]]; then
##      popd -n +$cnt 2>/dev/null 1>/dev/null
##      cnt=cnt-1
##    fi
##  done

  return 0
}

alias cd=cd_func

# ex - archive extractor
# usage: ex <file>
function ex () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

function extr() {
  local c e i

  (($#)) || return

  for i; do
    c=''
    e=1

    if [[ ! -r $i ]]; then
      echo "$0: file is unreadable: \`$i'" >&2
      continue
    fi

    case $i in
      *.t\(gz|lz|xz|b\(2|z?\(2\)\)|a\(z|r?\(.\(Z|bz?\(2\)|gz|lzma|xz\)\)\)\) ) c='bsdtar xvf';;
      *.7z)  c='7z x';;
      *.Z)   c='uncompress';;
      *.bz2) c='bunzip2';;
      *.exe) c='cabextract';;
      *.gz)  c='gunzip';;
      *.rar) c='unrar x';;
      *.xz)  c='unxz';;
      *.zip) c='unzip';;
      *)    echo "$0: unrecognized file extension: \`$i'" >&2
      continue;;
    esac

    command $c "$i"
    e=$?З
  done

  return $e
}

# Error if in one line without trailing `;` !
# One line functions inside { ... } must end with a semicolon.

function pcd() { cd $(find $1 -type d | percol); }
function xrpm() { rpm2cpio "$1" | cpio -idmv; }
function vack() { vim `ack-grep -g $@`; }
function mdcd() {
  if test -d "$1" -o -z "$1"; then
    tmpdir=$(mktemp -d -p.)
  else
    tmpdir=$1 && mkdir "$tmpdir"
  fi
  cd "$tmpdir";
}

function settitle() { echo -ne "\e]2;$@\a\e]1;$@\a"; }

# dir for `rm` backup:
  [ -z $MYSAV ] && MYSAV="/$HOME/.local/share/Trash"
  [ -d $MYSAV ] || mkdir -p $MYSAV

function rm {
  #usage:
  # remove: $ rm files
  # use \rm to call original rm, or `which rm`
  #
# mountpoint, /var/tmp
# mountpoint, /tmp
# /etc/default/rcS
# delete files in /tmp during boot older than x days.
# '0' means always, -1 or 'infinite' disables the feature
#TMPTIME=0

  # I had tried to use (dirname $myfile) to replace (pwd) to save two cd,
  # but dirname is relative to current working dir, not absolute dir.

  #mv -f $(basename $myfile) ${MYSAV}/$(find $(pwd) -maxdepth 1 -name $(basename $myfile)  |tr "/" "-")--`date +%Y-%m-%d-%H-%M-%S`
  # date +%F equals to date +%Y-%m-%d

  # then must be on next line of if ??

  (($#==0)) && { echo "No parameters!"; return 0; }
  ## ??
  ##  1==0: not found

  # for myfile in $*
  # $* is hard to deal with spaces within path.
  for myfile in "$@"
  do
    # For symbol links, same to "-L"
    if test -h "$myfile"; then
      /bin/rm "$myfile"
    elif test -e "$myfile"; then
      #savepath=`pwd`
      mv -f "$myfile" ${MYSAV}/$(date +%Y%m%d-%H%M%S-%s)_$(echo $(basename -- "$myfile") | tr "[\-\ \!\)\(\]\[\|\'\;\:\&\,\#\@\{\}\^]" "_")
      #cd "${savepath}"
    else
      echo "$myfile: No such file or directory!"
    fi
  done

  # Fixed: for myfile in "$*", and add "" for all myfile instances and change spaces to ^
  # Fixed: Failed for multi files if add "$*",
  # Fixed: just because "" in for myfile in "$*" above, get rid of
  # Fixed: error if the restored is a dir
  # FIXME: cannot move soft link
  #2==0: not found

  # To read:
  # undelete mini-HOWTO
  # safedelete
    #exit 0

} # end of function rm

# Functions end

#!?command

#ibus-daemon -r -d

# no LOGNAME for root
#if [[ $EUID == 0 ]] ; then

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
  case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
    cat <<-EOF
  To run a command as root, use "sudo <command>".
  See "man sudo_root" for details.

EOF
    fi
  esac
fi

# test -r ~/.vim/branch_prompt.sh && source ~/.vim/branch_prompt.sh

function prompt_git() {
  local s='';
  local branchName='';

  # Check if the current directory is in a Git repository.
  if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

  # check if the current directory is in .git before running git checks
  if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

  # Ensure the index is up to date.
  git update-index --really-refresh -q &>/dev/null;

  # Check for uncommitted changes in the index.
  if ! $(git diff --quiet --ignore-submodules --cached); then
  s+='+';
  fi;

  # Check for unstaged changes.
  if ! $(git diff-files --quiet --ignore-submodules --); then
  s+='!';
  fi;

  # Check for untracked files.
  if [ -n "$(git ls-files --others --exclude-standard)" ]; then
  s+='?';
  fi;

  # Check for stashed files.
  if $(git rev-parse --verify refs/stash &>/dev/null); then
  s+='$';
  fi;

  fi;

  # Get the short symbolic ref.
  # If HEAD isnt a symbolic ref, get the short SHA for the latest commit
  # Otherwise, just give up.
  branchName="$(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
  git rev-parse --short HEAD 2> /dev/null || \
  echo '(unknown)')";

  [ -n "${s}" ] && s="${s}";

  echo -e " ${1}(${branchName}${BLUE}${s}${GREEN})";
  else
  return;
  fi;
}

# exports
#export PKG_CONFIG_PATH=/usr/lib/pkgconfig
#export LD_LIBRARY_PATH=/lib:/usr/lib
#export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/share/lib:/usr/local/lib:/usr/local/share/lib:/usr/X11R6/lib:/opt/lib


#QUILT
#export QUILT_PATCHES="debian/patches"
#export QUILT_PUSH_ARGS="--color=auto"
#export QUILT_DIFF_ARGS="--no-timestamps --no-index -p ab --color=auto"
#export QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"
#export QUILT_DIFF_OPTS='-p'


# export INPUTRC=/etc/inputrc
export MAIL=$HOME/Mail/
export MAIL=$HOME/Maildir/
export EDITOR=vim
export USER LOGNAME MAIL HOSTNAME
export VISUAL=$EDITOR
export CSCOPE_EDITOR="$EDITOR"
export WCDHOME="${HOME}/.wcd"
export BROWSER="x-www-browser"

# export RESIN_HOME
export SHLVL=1
export G_BROKEN_FILENAMES=1

#export LANG=fr_CA

# Begin protected block
if [ -t 0 ]; then       # check for a terminal
  [ x"$TERM" = x"wy30" ] && stty erase ^h       # sample legacy environment
  #/usr/games/fortune
fi
# End protected block


##PS1 ----------------------------------------
# extra backslash in front of \$ to make bash colorize the prompt
# man bash, PROMPTING
  # for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt

# Set GPG_TTY for curses pinentry # man gpg-agent
if test -t && type -p tty > /dev/null 2>&1 ; then
  #export GPGKEY=""
   export GPG_TTY="$(tty)"
fi
  TTY=$(tty)
  TTY=${TTY##*/}

powerpercent() {
   test -r /sys/class/power_supply/BAT0/capacity &&\
   cat /sys/class/power_supply/BAT?/capacity | tr '\n' '%'
}

bash_prompt_command() {
  # How many characters of the $PWD should be kept
  pwdmaxlen=25
  # Indicate that there has been dir truncation
  trunc_symbol=".."
  dir=${PWD##*/}
  pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
  NEW_PWD=${PWD/#$HOME/\~}
  pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
  if [ ${pwdoffset} -gt "0" ]
  then
    NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
    NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
  fi
}

shopt -s checkhash cmdhist expand_aliases histreedit mailwarn
shopt -s hostcomplete

########################################
#Completion options
bind "set show-all-if-ambiguous on"   #enable single tab completion
bind "set completion-ignore-case on"

function proml {
    # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
    # If this is an xterm set the title to user@host:dir
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
    #PROMPT_COMMAND='printf "%b" "\033]0;${PWD/$HOME/~}\007"' ;;

    case $TERM in
        [aEkx]term*|tmux|screen|alacritty|kitty|*color)
            local TITLEBAR='\[\e]0;\u@\h:\w/ \007\]'
            use_color=true
            ;;
        *)
            local TITLEBAR=''
            ;;
    esac
}

proml
unset proml

function PWD {
  tmp=${PWD%/*/*};
  [ ${#tmp} -gt 0 -a "$tmp" != "$PWD" ] && echo ${PWD:${#tmp}+1} || echo $PWD;
}


#[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && . $HOME/.autojump/etc/profile.d/autojump.sh

#FIXME
#certutil: function failed: SEC_ERROR_PKCS11_GENERAL_ERROR: A PKCS #11 module returned CKR_GENERAL_ERROR, indicating that an unrecoverable error has occurred.

##startup programs ----------------------------------------

#For properly registering the ConsoleKit session, you probably want to add --with-ck-launch with startxfce4
#By default xfce4-session tries to start the gpg- or ssh-agent. To disable this run the following commands:
#xfconf-query -c xfce4-session -p /startup/ssh-agent/enabled -n -t bool -s false
#xfconf-query -c xfce4-session -p /startup/gpg-agent/enabled -n -t bool -s false

#To force the ssh-agent instead of the gpg-agent use the following command:
#xfconf-query -c xfce4-session -p /startup/ssh-agent/type -n -t string -s ssh-agent

# SSH agent
SSH_ENV=$HOME/.ssh/environment

function start_agent {
    echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed ''s/^echo/#echo/'' > ${SSH_ENV}
    echo succeeded
    chmod 600 ${SSH_ENV}
    . ${SSH_ENV} > /dev/null
    /usr/bin/ssh-add;
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" ]; then
    . ${SSH_ENV} > /dev/null
    #ps ${SSH_AGENT_PID} doesn''t work under cywgin
    \ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

# if we have private ssh key(s), start ssh-agent and add the key(s)
##id1=$HOME/.ssh/identity
##id2=$HOME/.ssh/id_dsa
##id3=$HOME/.ssh/id_rsa
##if [ -x /usr/bin/ssh-agent ] && [ -f $id1 -o -f $id2 -o -f $id3 ];
##then
  ##eval `ssh-agent -s`
  ##ssh-add < /dev/null
##fi

## PATH
# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            test -d $1 && PATH="$PATH:$1"
            ;;
    esac
}

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"
appendpath '/usr/games'
appendpath '/opt/bin'
appendpath '/usr/local/bin'
appendpath $HOME/.local/heroku/bin
appendpath $HOME/.gem/ruby/bin
appendpath "$HOME/.local/bin"

# fzf {{{
[ -f ~/.fzf.bash ] && source ~/.fzf.bash


# only in Util-Linux; not work for BSD
#setterm -blength 0

export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5

#export ftp_proxy=http://proxy.global.net:8080
#export http_proxy=http://proxy.global.net:8080
#export https_proxy=http://proxy.global.net:8080
#export no_proxy=localhost,127.0.0.1,10.*,.local

export IPOD_MOUNTPOINT=/media/

# export BBSHOME="/home/bbs"
# export WWWHOME="/home/bbs/www"
# export PHPHOME="/home/bbs/www/php"
# export SRCDIR="/home/"

if [ ! $DISPLAY ] ; then
  if [ "$SSH_CLIENT" ] ; then
  export DISPLAY=`echo $SSH_CLIENT|cut -f1 -d\ `:0.0
  fi
fi

#eval `keychain --eval --agents ssh id_rsa`
#eval `keychain --eval ~/.ssh/id_dsa`
#eval `keychain --eval ~/.ssh/id_rsa`

# curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o repo
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"


# if ! -z $CROSS_
# export CROSS_COMPILE=ppc_85xx-
# export TARGET_OS=linux

#fix java ugliness
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#}2

#byobu-prompt#
[ -r /usr/share/byobu/profiles/bashrc ] && . /usr/share/byobu/profiles/bashrc

# Term
#/etc/terminfo/*
# This directory is for system-local terminfo descriptions. By default,
# ncurses will search ${HOME}/.terminfo first, then /etc/terminfo (this
# directory), then /lib/terminfo, and last not least /usr/share/terminfo.

# Tmux explicitly requires this to be set to screen-256color.
export TERM=screen-256color

# TERM in .bashrc overrides `set -g default-terminal` from tmux

# set TERM to xterm-256color if bash is running standalone (no tmux)
[ -z "$TMUX" ] && export TERM="xterm-256color"
# http://invisible-island.net/xterm/xterm.faq.html#xterm_terminfo
# http://invisible-island.net/ncurses/terminfo.src.html#tic-screen-256color-bce
# http://invisible-island.net/ncurses/ncurses.faq.html#bce_mismatches
# tmux doesn't support the terminfo capability bce (back color erase), which vim checks for, to decide whether to use its "default color" scheme.

# These should be in ~/.xprofile for DM session
## Take care of dbus-launch
# for IME in sway and alike
# See http://fcitx-im.org/wiki/Input_method_related_environment_variables#XMODIFIERS
##export GTK_IM_MODULE=xim
#export GTK_IM_MODULE=fcitx
###export QT_IM_MODULE=xim
#export QT_IM_MODULE=fcitx
##export QT_IM_MODULE=xim
#export XMODIFIERS=@im=fcitx

# Start SWAY if login from the specified console.
# if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
#   exec sway

#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
    # now use nodm, comment out
# if [ "$(tty)" == "/dev/tty3" -o "$(tty)" = "/dev/vc/1" ] ; then
#     #startx
#     sway
#     exit 0    # exit login after sway quits
# fi

case "$(tty)" in
    "/dev/tty5")    sway; exit 0;;
    "/dev/tty6")    startxfce4; exit 0;;
    "/dev/vc/1")    sway; exit 0;;
esac


# TODO: log out after idle long time

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.bash.inc" ]; then
  source "$HOME/google-cloud-sdk/completion.bash.inc"
fi
# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.bash.inc" ]; then . "$HOME/google-cloud-sdk/path.bash.inc"; fi

export GOPATH=$HOME/go
appendpath $GOPATH/bin

[ "$UID" = "0" ] || appendpath "."

#set -o emacs
set -o vi

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
appendpath "$HOME/.rbenv/shims"

## alacritty
test -d  ~/.config/alacritty/alacritty.bash && source ~/.config/alacritty/alacritty.bash

# kitty
which kitty &>/dev/null && source <(kitty + complete setup bash)
##Older versions do not support process substitution with the source command
##try an alternative:
# source /dev/stdin <<<"$(kitty + complete setup bash)"

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

test 0 -eq $(id -u) || source ~/.git-completion.bash
test 0 -eq $(id -u) || source ~/.git-prompt.sh

export GIT_PS1_SHOWDIRTYSTATE=1

#source ~/.vim/scripts/branch_prompt.sh

# highlight syntax in man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\E[0m'           # end mode

export LESS_TERMCAP_so=$'\E[34;7;246m'    # begin standout-mode - info box
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode

export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESS_TERMCAP_ue=$'\E[0m'           # end underline

#man() {
#    LESS_TERMCAP_md=$'\e[01;31m' \
#    LESS_TERMCAP_me=$'\e[0m' \
#    LESS_TERMCAP_us=$'\e[01;32m' \
#    LESS_TERMCAP_ue=$'\e[0m' \
#    LESS_TERMCAP_so=$'\e[45;93m' \
#    LESS_TERMCAP_se=$'\e[0m' \
#
#    command man "$@"
#}

appendpath $HOME/.cargo/bin
. "$HOME/.cargo/env"

# Original PATH is set in /etc/profile
# NEVER export PATH without quoting $PATH

#For Java
# export JAVA_HOME=/usr/lib/jvm/java-6-sun-1.6.0.14/jre/
[ ! -z $JAVA_HOME ] && export PATH=$JAVA_HOME/bin:$PATH
[ ! -z $JAVA_HOME ] && export LD_LIBRARY_PATH=$JAVA_HOME:$LD_LIBRARY_PATH
[ ! -z $JAVA_HOME ] && export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/td.jar:$JAVA_HOME/lib/rt.jar:.


# brew
appendpath "$HOME/.brew/bin"
export MANPATH="$HOME/.brew/share/man:$MANPATH"
export INFOPATH="$HOME/.brew/share/info:$INFOPATH"
export HOMEBREW_BUILD_FROM_SOURCE=1

export LABS="${HOME}/.local"
export BBDIR="${LABS}/bitbake"

appendpath ${BBDIR}/bin

unset appendpath

function PWD {
  tmp=${PWD%/*/*};
  [ ${#tmp} -gt 0 -a "$tmp" != "$PWD" ] && echo ${PWD:${#tmp}+1} || echo $PWD;
}


#{3
if [ -f "$(command -v "ccache")" ]; then
    export PATH="${PATH}:/usr/lib/ccache"
    export CCACHE_DIR="${HOME}/.ccache"
    export CCACHE_SIZE="2G"
    #export CCACHE_PREFIX="distcc"
fi
#}3

if test -d $HOME/.fzf ; then
  if [[ ! "$PATH" == *$HOME/.fzf/bin* ]]; then
    export PATH="${PATH:+${PATH}:}$HOME/.fzf/bin"
  fi

  # Auto-completion
  [[ $- == *i* ]] && source "$HOME/.fzf/shell/completion.bash" 2> /dev/null

  # Key bindings
  test -f $HOME/.fzf/shell/key-bindings.bash && source "$HOME/.fzf/shell/key-bindings.bash"
fi # fzf }}}

#perl5
[ -d "$HOME/.local/perl5/bin" ] && export PATH="$HOME/.local/perl5/bin${PATH:+:${PATH}}";
PERL5LIB="$HOME/.local/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.local/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.local/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl5"; export PERL_MM_OPT;

# ruby
#[ -f "${HOME}/.rvm/bin" ] && export PATH="${PATH}:${HOME}/.rvm/bin"
#[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if which rbenv 2>/dev/null ; then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

#export ENV=$HOME/.bashrc

PATH="$PATH:./node_modules/.bin"
export NODE_MIRROR=https://mirrors.tuna.tsinghua.edu.cn/nodejs-release/

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion


TZ='Asia/Shanghai'; export TZ

## [ "$UID" = "0" ] || export PATH=".:$PATH"

# Load RVM into a shell session *as a function*
#export PATH="$PATH:$HOME/.rvm/bin"
# Use the following; Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


function box() {
  test -f ~/.ssh/known_hosts && ssh-keygen -f ~/.ssh/known_hosts -R $1 2>/dev/null 1>&2
  ssh-keyscan $1 >> ~/.ssh/known_hosts 2>/dev/null 1>&2
  for p in pica8 12345678; do sshpass -p $p ssh admin@$1 && break; done
}

#eval "$(lessfile)"
# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

#LESSOPEN="|lesspipe.sh %s"; export LESSOPEN


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function ahead_behind() {
  curr_branch=$(git rev-parse --abbrev-ref HEAD);
  curr_remote=$(git config branch.$curr_branch.remote);
  curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3);
  git rev-list --quiet HEAD && git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch | tr -s '\t' '|';
}

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi


if [ "$color_prompt" = yes ]; then
    # override default virtualenv indicator in prompt
    VIRTUAL_ENV_DISABLE_PROMPT=1

    prompt_color='\[\033[;32m\]'
    info_color='\[\033[1;34m\]'
    #prompt_symbol=㉿
    prompt_symbol=@
    if [ "$EUID" -eq 0 ]; then # Change prompt colors for root user
    prompt_color='\[\033[;94m\]'
    info_color='\[\033[1;31m\]'
    prompt_symbol=💀
    fi
    #PS1=$prompt_color'┌──${debian_chroot:+($debian_chroot)──}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}('$info_color'\u${prompt_symbol}\h'$prompt_color')-[\[\033[0;1m\]\w'$prompt_color']\n'$prompt_color'└─'$info_color'\$\[\033[0m\] '
    PS1=$prompt_color'${debian_chroot:+($debian_chroot)-}${VIRTUAL_ENV:+(\[\033[0;1m\]$(basename $VIRTUAL_ENV)'$prompt_color')}'$info_color'\u${prompt_symbol}\h'$prompt_color':\[\033[0;1m\]\w'$prompt_color'/ '$prompt_color' '$info_color
    # BackTrack red prompt
    #PS1='${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV)) }${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '

#PS1=$PS1"$(PWD)\/\n "
PS1="${TITLEBAR}$BGreen# \D{W%V.%u %m%d} \t$(__git_ps1) \$(powerpercent) jobs:\j "$PS1
PS1="\[\e[\$(( (\$? == 0 ) ? 31 : 41 ))m\]"$PS1
PS1=$PS1$NORMAL"\n$ "

else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

case "$TERM" in
    [aEkx]term*|tmux|screen|alacritty|kitty|*color)
        # set the title to user@host:dir
        PROMPT_COMMAND=${PROMPT_COMMAND:+$PROMPT_COMMAND; }'printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"'
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        use_color=true
        ;;
    *)
        ;;
esac


# colors
darkgrey="$(tput bold; tput setaf 0)"
white="$(tput bold; tput setaf 7)"
red="$(tput bold; tput setaf 1)"
nc="$(tput sgr0)"

#export PS1="\[$darkgrey\][ \[$red\]\u@\h \[$white\]\W\[$red\] \[$darkgrey\]]\\[$red\]# \[$nc\] \w$ "

# Completion options
#These completion tuning parameters change the default behavior of bash_completion:

#Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1

#Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1


## if ! shopt -oq posix; then
# source user completion file
# LOCAL_BASH_COMPLETION="${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
# [ $BASH_COMPLETION != $LOCAL_BASH_COMPLETION -a -r $LOCAL_BASH_COMPLETION ] && . $LOCAL_BASH_COMPLETION
# Update: it had been done in
# bash-completion: /etc/profile.d/bash_completion.sh
# Also there: source files
#[ -r /usr/share/bash-completion/completions ] &&
#  . /usr/share/bash-completion/completions/*

#trap '. /etc/bash_completion ; trap USR2' USR2
#{ sleep 0.01 ; builtin kill -USR2 $$ ; } & disown
#   https://github.com/scop/bash-completion

complete -W menuconfig make
complete -cf sudo

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions into a separate file
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
test -f ~/.aliases && . ~/.aliases

# sets pygmentize as the syntax highlighter rather than the built-in code2color
if type pygmentize >/dev/null 2>&1; then
	export LESSCOLORIZER='pygmentize'
fi

# source files
[ -r /usr/share/bash-completion/completions ] &&
  . /usr/share/bash-completion/completions/*

## Autostart X at login
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx ~/.config/xorg/xinitrc


# Set user-defined locale
#TODO
#export LANG=$(locale -uU)
# export LANGUAGE="zh_CN:zh:en"
# export LANG="zh_CN.utf8"
export LANG="en_US.utf8"

# Set MANPATH so it includes users' private man if it exists
if [ -d "${HOME}/man" ]; then
   MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes users' private info if it exists
if [ -d "${HOME}/info" ]; then
   INFOPATH="${HOME}/info:${INFOPATH}"
fi

# Load RVM into a shell session *as a function*
#export PATH="$PATH:$HOME/.rvm/bin"
# Use the following; Add RVM to PATH for scripting
#[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#TODO
# bash: keychain: command not found
#eval `keychain --eval --agents ssh id_rsa`
#eval `keychain --eval ~/.ssh/id_dsa`
#eval `keychain --eval ~/.ssh/id_rsa`

# exports
export LD_PRELOAD=""
#export VISUAL=vim
#export EDITOR=vim
# export INPUTRC=/etc/inputrc
#export USER LOGNAME MAIL HOSTNAME
# source ~/.inputrc

if [ -n "$BASH" -a -n "$BASH_VERSION" ]; then
# Notify of job termination immediately.
	set -b
fi

# Specific bashrc
[[ -f $HOME/.bashrc.local ]] && . $HOME/.bashrc.local

