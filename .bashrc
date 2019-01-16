# ~/.bashrc: executed by bash(1) for non-login shells.
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in profile.
#
# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.

# Shell is non-interactive.  Be done now!
[[ $- != *i* ]] && return

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#do nothing if not running interactively
[ -z "${PS1}" ] && exit


#QUOTE    BEGIN
    ## System-wide .profile for sh(1)

    #if [ -x /usr/libexec/path_helper ]; then
        #eval `/usr/libexec/path_helper -s`
    #fi
#
    #if [ "${BASH-no}" != "no" ]; then
        #[ -r /etc/bashrc ] && . /etc/bashrc
    #fi
#QUOTE    END


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


### history
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
export HISTSIZE=50000
HISTFILESIZE=60000

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace
#HISTCONTROL=ignoreboth

# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify
export PROMPT_COMMAND="history -a"

### history end


#Completion options
#These completion tuning parameters change the default behavior of bash_completion:
#
#Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1
#
#Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1
#
#Uncomment to turn on programmable completion enhancements.
#Any completions you add in ~/.bash_completion are sourced last.
[[ -f /etc/bash_completion ]] && . /etc/bash_completion


#History Options
#
#Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
#Ignore some controlling instructions
#HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit'
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls' # Ignore the ls command as well
#
#Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

# source user completion file
#[ $BASH_COMPLETION != ~/.bash_completion -a -r ~/.bash_completion ] && . ~/.bash_completion
# [ -r /etc/bash_completion ] && . /etc/bash_completion
# enable programmable completion features (you don't need to enable this, if
# it's already enabled in /etc/bash.bashrc and /etc/profile ).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


# If this is an xterm set the title to user@host:dir
case "$TERM" in
    # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
    # If this is an xterm set the title to user@host:dir
    xterm*|rxvt*)
    # xterm-color)
        color_prompt=yes
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

        fi
    ;;

screen)
    if [ -e /etc/sysconfig/bash-prompt-screen ]; then
        PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
    else
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
    # PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
    fi
    ;;
*)
    [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

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


if [ "$PS1" ]; then
  if [ "$BASH" ]; then
    PS1='\u@\h:\w\$ '

    # Source global definitions
    if [ -f /etc/bashrc ]; then
        . /etc/bashrc
    fi

    if [ -f /etc/bash.bashrc ]; then
	. /etc/bash.bashrc
    fi

  else
    if [ "`id -u`" -eq 0 ]; then
      PS1='# '
    else
      PS1='$ '
    fi
  fi
fi

# only in Util-Linux; not work for BSD
#setterm -blength 0


##Color scheme
# Reset
Color_Off='\e[0m'       # Text Reset
NORMAL="\[\e[0m\]"

# Color define

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

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

###Color
unset color_prompt force_color_prompt

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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


# Setup a red prompt for root and a green one for users.
NORMAL="\[\e[0m\]"
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]] ; then
	PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
	PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found -o -x /usr/share/command-not-found ]; then
	function command_not_found_handle {
	        # check because c-n-f could've been removed in the meantime
                if [ -x /usr/lib/command-not-found ]; then
		   /usr/bin/python /usr/lib/command-not-found -- $1
                   return $?
                elif [ -x /usr/share/command-not-found ]; then
		   /usr/bin/python /usr/share/command-not-found -- $1
                   return $?
		else
		   return 127
		fi
	}
fi

# set a fancy prompt (non-color, overwrite the one in /etc/profile)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
    # If this is an xterm set the title to user@host:dir
    xterm*|rxvt*)
    # xterm-color)
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
        #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        if [ -e /etc/sysconfig/bash-prompt-xterm ]; then
            PROMPT_COMMAND=/etc/sysconfig/bash-prompt-xterm
        else
            PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
            #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'

        fi
    ;;

screen)
    if [ -e /etc/sysconfig/bash-prompt-screen ]; then
        PROMPT_COMMAND=/etc/sysconfig/bash-prompt-screen
    else
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
    # PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
    fi
    ;;
*)
    [ -e /etc/sysconfig/bash-prompt-default ] && PROMPT_COMMAND=/etc/sysconfig/bash-prompt-default
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    ;;
esac

# set -o vi

unset -f have
unset UNAME RELEASE default dirnames filenames have nospace bashdefault plusdirs

###  Local Variables:
###  mode: shell-script
###  End:
complete -W menuconfig make

if ! shopt -q login_shell ; then # We're not a login shell
    # Need to redefine pathmunge, it get's undefined at the end of /etc/profile
    pathmunge () {
        if ! echo $PATH | /bin/egrep -q "(^|:)$1($|:)" ; then
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
        fi
    }

##FIXME time consuming
    for i in /etc/profile.d/*.sh; do
        #[ -r "$i" ] && . $i
        [ -r "$i" ] && echo $i
    done
    unset i
    unset pathmunge
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

##.... PS1='\[\033[01;34m\]$(date +%H%M) ${debian_chroot:+($debian_chroot)}\u@\w\$\[\033[00m\] '
#PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
# PS1="\[\033[4;41;37m\]:\w\$\[\033[0m\] "
# [ "$PS1" = "\\s-\\v\\\$ " ] && PS1="[\u@\h \W]\\$ "

function vack {
# apt-get install ack-grep
vim `ack-grep -g $@`
}

function rm {

    # create a dir for backup:
    #[ -z $MYSAV ] && MYSAV="$HOME/.local/share/Trash"
    [ -z $MYSAV ] && MYSAV="/path/var/tmp/Trash"

    # for replace "\rm", under teting.
    [ -d $MYSAV ] || mkdir -p $MYSAV


    #usage:
    # remove: $ rm files
    # use \rm to call original rm, or `which rm`
    #
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
        if test -e "$myfile"
            then
                savepath=`pwd`
                #cd $(dirname "$myfile")
                mv -f "$myfile" ${MYSAV}/
                #mv -f "$(basename "$myfile")" ${MYSAV}/$(date +%b-%d-%H-%M-%S)-$(echo $(pwd)/$(basename "$myfile") |tr "/" "-" |tr " " "^")
                #cd "${savepath}"
        else
            echo "$myfile:No such file or directory!"
        fi
    done

    #exit 0

    # Changelog
    # Fixed: Failed if files not exist
    # Fixed: Failed if filename contains space
    # Fixed: for myfile in "$*", and add "" for all myfile instances and change spaces to ^
    # Fixed: Failed for multi files if add "$*",
    # Fixed: just because "" in for myfile in "$*" above, get rid of
    # Fixed: error if the restored is a dir
    # FIXME: cannot move soft link
    # rm -r xxx
    #2==0: not found
    #mv: rename =home=xxx-...11-04-17 to /home/xxx/intro_files: No such file or directory

    # To read:
    # undelete mini-HOWTO
    # safedelete

}   # end of function rm

mdcd() {
  mkdir -p "$1" && cd "$1"
}


# Bash is using readline to handle the prompt. ~/.inputrc is the configuration file for readline.


bind -r "\033[A"
bind -r "\033OA"
bind -r "\033[B"
bind -r "\033OB"
bind '"\033[A":history-search-backward'
bind '"\033OA":history-search-backward'
bind '"\033[B":history-search-forward'
bind '"\033OB":history-search-forward'

# ~/.inputrc
## arrow up
#"\e[A": history-search-backward
## arrow down
#"\e[B": history-search-forward
#or equivalently,

# ~/.bashrc
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#Normally, Up and Down are bound to the Readline functions previous-history and next-history respectively. I prefer to bind PgUp/PgDn to these functions, instead of displacing the normal operation of Up/Down.

# ~/.inputrc
#"\e[5~": history-search-backward
#"\e[6~": history-search-forward
#After you modify ~/.inputrc, restart your shell or use Ctrl+X, Ctrl+R to tell it to re-read ~/.inputrc.


#!?command

# To get the escape codes for the arrow keys you can do the following:
#Start cat in a terminal (just cat, no further arguments).
#Type keys on keyboard, you will get things like ^[[A for up arrow and ^[[B for down arrow.
#Replace ^[ with \e.

#ibus-daemon -r -d


# no LOGNAME for root
#if [[ $EUID == 0 ]] ; then

# sudo hint
if [ ! -e "$HOME/.sudo_as_admin_successful" ]; then
    case " $(groups) " in *\ admin\ *)
    if [ -x /usr/bin/sudo ]; then
	cat <<-EOF
	To run a command as administrator (user "root"), use "sudo <command>".
	See "man sudo_root" for details.
	
	EOF
    fi
    esac
fi


#function settitle
settitle ()
{
  echo -ne "\e]2;$@\a\e]1;$@\a";
}



#Shell Options
#
#See man bash for more options...
#
#Don't wait for job termination notification
set -o notify
#
#Use case-insensitive filename globbing
shopt -s nocaseglob
#
#When changing directory small typos can be ignored by bash
#for example, cd /vr/lgo/apaache would find /var/log/apache
shopt -s cdspell

# sometimes, stty eof '^D' / stty eof undef
#Don't use ^D to exit
#IGNOREEOF=10   # Shell only exists after the 10th consecutive Ctrl-d
#set -o ignoreeof  # Same as setting IGNOREEOF=10
#set ignoreeof        # prevent accidental shell termination
export IGNOREEOF=2

##PS1 ----------------------------------------
unset PS1
TTY=$(tty)
TTY=${TTY##*/}

#For csh.rc, # set prompt = "%U%{\033[41;37m%}%m:%~%#%{\033[0m%}%u "
##bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
#if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor

# 033 = e
# PS1="\[\e[0;33m\]\D{W%V.%u %a %b %d,} \t\[\e[1;34m\] \u\[\e[1;33m\]@\[\e[36;01m\]\h\[\e[37;00m\] \w\n\$ \[\e[0m\]"
# PS1="\e[1;37m[\e[m\e[1;32m\u\e[m\e[1;33m \e[m\e[1;35m\h\e[m \e[4m \e[m\e[1;37m]\e[m\e[1;36m\e[m\\$ "
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;36m\]C:\w \[\033[00m\]> '
#if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor

PS1='\u@$(hostname):$( printf "%s" "${PWD/${HOME}/~}")\n\$ '
#PS1=$BYellow"@$TTY@\\s-\\v "$Cyan$PS1
PS1="$BGreen\D{W%V.%u %a %b %d, }$UPurple\t$NORMAL $BBlue"$PS1$NORMAL


##FIXME
#$ tty
#/dev/ttys003
#$ uname -a
#Darwin Mato.local 14.0.0 Darwin Kernel Version 14.0.0: Fri Sep 19 00:26:44 PDT 2014; root:xnu-2782.1.97~2/RELEASE_X86_64 x86_64


#TODO
# stty: invalid argument ‘iutf8’
# Try 'stty --help' for more information.
#TODO
# bash: keychain: command not found

#TODO
# if no "-" , .profile won't be loaded??
# such as in "su -", or "mintty -"

#TODO
#ctrl-RIGHT got 5C





# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set notildeop

unset -f have
unset use_color safe_term match_lhs sh
unset UNAME RELEASE default dirnames filenames have nospace bashdefault plusdirs

#set -o vi #this is sparta!

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.

# Even for non-interactive, non-login shells.
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


#if [ "${BASH-no}" != "no" ]; then
#[ -r /etc/bashrc ] && . /etc/bashrc
#fi

# Source global definitions
if [ -f /etc/bash.bashrc ]; then . /etc/bash.bashrc; fi

#TODO
# bash: keychain: command not found
#eval `keychain --eval --agents ssh id_rsa`
#eval `keychain --eval ~/.ssh/id_dsa`
#eval `keychain --eval ~/.ssh/id_rsa`

# source
test -r /fink/bin/init.sh && . /fink/bin/init.sh


########################################
## Timezone
TZ='Asia/Shanghai'; export TZ


########################################
# locale
# export LANGUAGE="zh_CN:zh:en"
#export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


#if [ "`locale charmap 2>/dev/null`" = "UTF-8" ]
#then
  #stty iutf8
#fi



########################################
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

## Regular Colors
BLACK='\e[0;30m'
RED='\e[0;31m'
GREEN='\e[0;32m'
YELLOW='\e[0;33m'
BLUE='\e[0;34m'
MAGENTA='\e[0;35m'
CYAN='\e[0;36m'
WHITE='\e[0;37m'
LIGHT_GRAY="\[\033[0;37m\]"

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# Reset
# unsets color to term's fg color
NORMAL='\e[0m'

# Bold
BBLACK='\e[1;30m'
BRED='\e[1;31m'
BGREEN='\e[1;32m'
BYELLOW='\e[1;33m'
BBLUE='\e[1;34m'
BPURPLE='\e[1;35m'
BCYAN='\e[1;36m'
BWHITE='\e[1;37m'

# Underline
UBLACK='\e[4;30m'
URED='\e[4;31m'
UGREEN='\e[4;32m'
UYELLOW='\e[4;33m'
UBLUE='\e[4;34m'
UPURPLE='\e[4;35m'
UCYAN='\e[4;36m'
UWHITE='\e[4;37m'

# Background
ON_BLACK='\e[40m'
ON_RED='\e[41m'
ON_GREEN='\e[42m'
ON_YELLOW='\e[43m'
ON_BLUE='\e[44m'
ON_MAGENTA='\e[45m'
ON_CYAN='\e[46m'
ON_WHITE='\e[47m'

# High Intensity
IBLACK='\e[0;90m'
IRED='\e[0;91m'
IGREEN='\e[0;92m'
IYELLOW='\e[0;93m'
IBLUE='\e[0;94m'
IPURPLE='\e[0;95m'
ICYAN='\e[0;96m'
IWHITE='\e[0;97m'

# Bold High Intensity
BIBLACK='\e[1;90m'
BIRED='\e[1;91m'
BIGREEN='\e[1;92m'
BIYELLOW='\e[1;93m'
BIBLUE='\e[1;94m'
BIPURPLE='\e[1;95m'
BICYAN='\e[1;96m'
BIWHITE='\e[1;97m'

# HIGH Intensity backgrounds
ON_IBLACK='\e[0;100m'
ON_IRED='\e[0;101m'
ON_IGREEN='\e[0;102m'
ON_IYELLOW='\e[0;103m'
ON_IBLUE='\e[0;104m'
ON_IPURPLE='\e[0;105m'
ON_ICYAN='\e[0;106m'
ON_IWHITE='\e[0;107m'



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

# only in Util-Linux; not work for BSD
#setterm -blength 0

##bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
#if [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor

# curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o repo
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'


#PATH
# NEVER export PATH without quoting $PATH
# Deal with PATH only in .bashrc, and source it in ~/.bash_profile
# Original PATH is set in /etc/profile

#For Java
# export JAVA_HOME=/usr/lib/jvm/java-6-sun-1.6.0.14/jre/
# [ ! -z $JAVA_HOME ] && export PATH=$JAVA_HOME/bin:$PATH
# export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/td.jar:$JAVA_HOME/lib/rt.jar:.
#export PATH=$JAVA_HOME/bin:/$HOME/.local/my-cross/bin:$PATH

# if ! -z $CROSS_
# export TARGET_OS=linux


# linuxbrew
export PATH="$HOME/.linuxbrew/bin:$PATH"
export MANPATH="$HOME/.linuxbrew/share/man:$MANPATH"
export INFOPATH="$HOME/.linuxbrew/share/info:$INFOPATH"
export HOMEBREW_BUILD_FROM_SOURCE=1

export LABS="${HOME}/.local"
export BBDIR="${LABS}/bitbake"
export PATH="${BBDIR}/bin:$PATH"

#QUILT
#export QUILT_PATCHES="debian/patches"
#export QUILT_PUSH_ARGS="--color=auto"
#export QUILT_DIFF_ARGS="--no-timestamps --no-index -p ab --color=auto"
#export QUILT_REFRESH_ARGS="--no-timestamps --no-index -p ab"
#export QUILT_DIFF_OPTS='-p'

#{3
if [ -f "$(command -v "ccache")" ]; then
    export PATH="${PATH}:/usr/lib/ccache"
    export CCACHE_DIR="${HOME}/.ccache"
    export CCACHE_SIZE="2G"
    #export CCACHE_PREFIX="distcc"
fi
#}3

###Heroku Toolbelt
[ -d "$HOME/.local/heroku/bin" ] && export PATH="$HOME/.local/heroku/bin:$PATH"

###Go
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

#perl5
[ -d "$HOME/.local/perl5/bin" ] && export PATH="$HOME/.local/perl5/bin${PATH:+:${PATH}}";
PERL5LIB="$HOME/.local/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.local/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.local/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl5"; export PERL_MM_OPT;

# ruby
#[ -f "${HOME}/.rvm/bin" ] && export PATH="${PATH}:${HOME}/.rvm/bin"
#[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

if which rbenv 2 >&/dev/null ; then
  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/shims:$PATH"
fi

# set PATH so it includes user's private bin if it exists
[ -d $HOME/.local/bin ] && PATH=$HOME/.local/bin:$PATH

[ -d $HOME/.gem/ruby/2.4.0/bin ] && PATH=$HOME/.gem/ruby/2.4.0/bin:$PATH

[ -d $HOME/.gem/ruby/2.5.0/bin ] && PATH=$HOME/.gem/ruby/2.5.0/bin:$PATH

[ -d $HOME/swift-3.1/usr/bin/ ] && PATH=$HOME/swift-3.1/usr/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.bash.inc' ]; then
  source '$HOME/google-cloud-sdk/path.bash.inc'
fi

export GOPATH=~/gopath

### Heroku Toolbelt
PATH="/usr/local/heroku/bin:$PATH"

# Dont clear the screen after quitting a manual page
export MANPAGER="less -X"
## less not as chinese pager
export LESSCHARSET=utf-8

#eval "$(lessfile)"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
#export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/share/lib:/usr/local/lib:/usr/local/share/lib:/usr/X11R6/lib:/opt/lib

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

#FIXME
#certutil: function failed: SEC_ERROR_PKCS11_GENERAL_ERROR: A PKCS #11 module returned CKR_GENERAL_ERROR, indicating that an unrecoverable error has occurred.

# export BBSHOME="/home/bbs"
# export WWWHOME="/home/bbs/www"
# export PHPHOME="/home/bbs/www/php"
# export SRCDIR="/home/"

# Original PATH is set in /etc/profile
# NEVER export PATH without quoting $PATH

#For Java
# [ ! -z $JAVA_HOME ] && export PATH=$JAVA_HOME/bin:$PATH
# export JAVA_HOME=/usr/lib/jvm/java-6-sun-1.6.0.14/jre/
# export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/td.jar:$JAVA_HOME/lib/rt.jar:.

# if ! -z $CROSS_
# export CROSS_COMPILE=ppc_85xx-
# export TARGET_OS=linux

#never
## [ "$UID" = "0" ] || export PATH=".:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export VISUAL=vim
export EDITOR=vim
export SVN_EDITOR=vim
# export INPUTRC=/etc/inputrc
export USER LOGNAME MAIL HOSTNAME

# export RESIN_HOME

export SHLVL=1
export CVS_RSH=ssh
export G_BROKEN_FILENAMES=1

#if [ "`locale charmap 2>/dev/null`" = "UTF-8" ]
#then
	#stty iutf8
#fi

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH

########################################
#Shell Options
#
#See man bash for more options...
#
#Don't wait for job termination notification
set -o notify

#http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
[ "${BASH_VERSINFO}" -ge "4" ] && shopt -s autocd cdspell dirspell
# cdspell
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache


#Use case-insensitive filename globbing
shopt -s nocaseglob

# Bash won't get SIGWINCH if another process is in the foreground.
# Check terminal size when it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# sometimes, stty eof '^D' / stty eof undef
#Don't use ^D to exit
#IGNOREEOF=10    # Shell only exists after the 10th consecutive Ctrl-d
#set -o ignoreeof  # Same as setting IGNOREEOF=10
#set ignoreeof  # prevent accidental shell termination
export IGNOREEOF=2

##FIXME
#$ tty
#/dev/ttys003
#$ uname -a

stty -ctlecho #don't show ^C when pressing Ctrl+C
#TODO
# stty: invalid argument iutf8
# Try 'stty --help' for more information.

#TODO
# bash: keychain: command not found

#TODO
# if no "-" , .profile won't be loaded??
# such as in "su -", or "mintty -"

#TODO
#ctrl-RIGHT got 5C

########################################
#bind
# Bash is using readline to handle the prompt.
# $HOME/.inputrc is the configuration file for readline.

# If bond, Some systems lacking of "" would mess HOME/END??
bind -r "\e[A"
bind -r "\e[B"
bind -r "\eOA"
bind -r "\eOB"
bind '"\e[A":history-search-backward'
bind '"\eOA":history-search-backward'
bind '"\e[B":history-search-forward'
bind '"\eOB":history-search-forward'

# $HOME/.bashrc
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#Normally, Up and Down are bound to the Readline functions previous-history and
# next-history respectively. I prefer to bind PgUp/PgDn to these functions,
# instead of displacing the normal operation of Up/Down.

# $HOME/.inputrc
#"\e[5~": history-search-backward
#"\e[6~": history-search-forward
#After modify $HOME/.inputrc, use Ctrl+X, Ctrl+R to tell it to re-read $HOME/.inputrc.

# To get the escape codes for the arrow keys you can do the following:
#Start cat in a terminal (just cat, no further arguments).
#Type keys on keyboard, you will get ^[[A for up arrow and ^[[B for down arrow.
#Replace ^[ with \e.

bind "set match-hidden-files off"     #don't match hidden files
bind "set bind-tty-special-chars on"  #punctuations are not word delimiters

#}1

#gpg
#export GPGKEY=""
#export GPG_TTY="$(tty)"

#fix java ugliness
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#}2


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

# init it by setting PROMPT_COMMAND
#PROMPT_COMMAND=bash_prompt_command

# Whenever displaying the prompt, write the previous line to disk
# to keep history even after abnormal bash quit,
# export PROMPT_COMMAND="history -a"
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
#PROMPT_COMMAND='history -a $HOME/.bash_history; echo -ne "\033]0;$PWD\007"; $PROMPT_COMMAND;'

shopt -s checkhash cmdhist expand_aliases histreedit mailwarn
shopt -s hostcomplete


########################################
#History Options

HISTIMEFORMAT="%F %T"
#The '&' is a special pattern which suppresses duplicate entries.
#HISTIGNORE="[ \t]*:&:[fb]g:pwd:date:exit:* --help"
HISTIGNORE="&:[fb]g:pwd:date:exit:* --help"


# append to the history file, don't overwrite it
shopt -s histappend

shopt -s histverify
# Save each command to the history file as it's executed.
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
#PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=60000


# Keep also space-starting lines, just in case
#HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups:ignorespace
# See bash(1) for more options
HISTCONTROL=ignoredups

# dont overwrite GNU Midnight Commanders setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups


# export QT_SELECT=4

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.


########################################
#Completion options
bind "set show-all-if-ambiguous on"   #enable single tab completion
bind "set completion-ignore-case on"

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# The next line enables bash completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.bash.inc' ]; then
  source '$HOME/google-cloud-sdk/completion.bash.inc'
fi


# bash-completion
#trap '. /etc/bash_completion ; trap USR2' USR2
#{ sleep 0.01 ; builtin kill -USR2 $$ ; } & disown
#[ -z "${BASH_COMPLETION_COMPAT_DIR}" ] && [ -f /etc/bash_completion ] && . /etc/bash_completion

#   https://github.com/scop/bash-completion
# shopt -oq posix; then

# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_COMPAT_DIR-}" ]; then

    # Check for recent enough version of bash.
    if [ ${BASH_VERSINFO[0]} -gt 4 ] || \
       [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then
        [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
            . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
        if shopt -q progcomp && [ -r /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        fi
    fi

fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi



complete -W menuconfig make
complete -cf sudo


#FIXME
#certutil: function failed: SEC_ERROR_PKCS11_GENERAL_ERROR: A PKCS #11 module returned CKR_GENERAL_ERROR, indicating that an unrecoverable error has occurred.

##startup programs ----------------------------------------
#export calendar=$HOME/.calendar/calendar.all

#! ps aux | grep -q fetchmail && fetchmail &
#! ( ps aux | grep -q fetchmail ) && fetchmail &


mdcd() {
  mkdir -p "$1" && cd "$1"
}


#function settitle
settitle ()
{
  echo -ne "\e]2;$@\a\e]1;$@\a";
}


function vack {
# apt-get install ack-grep
vim `ack-grep -g $@`
}

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

} # end of function rm


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


# exports

export EDITOR=vim
export VISUAL=$EDITOR
export CSCOPE_EDITOR="$EDITOR"
export WCDHOME="${HOME}/.wcd"
#export BROWSER="chromium"
export BROWSER="firefox"
export BROWSER="x-www-browser"


# export INPUTRC=/etc/inputrc
export USER LOGNAME MAIL HOSTNAME

# export RESIN_HOME

export SHLVL=1
export G_BROKEN_FILENAMES=1


# if the command-not-found package is installed, use it
if [ -x /usr/share/command-not-found/command-not-found ]; then
  function command_not_found_handle {
  # check because c-n-f could've been removed in the meantime
  if [ -x /usr/share/command-not-found/command-not-found ]; then
    /usr/share/command-not-found/command-not-found -- "$1"
    return $?
  else
    printf "%s: command not found\n" "$1" >&2
    return 127
  fi
  }
fi


########################################
# colorful

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


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


use_color=false

if type -P dircolors >/dev/null; then
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
  [aEkx]term*|rxvt*|gnome*|konsole*|screen|cons25|*color) use_color=true;;
  esac
fi

# Set colorful PS1 only on colorful terminals.

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if [[ -f ~/.dir_colors ]] ; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [[ -f /etc/DIR_COLORS ]] ; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  else
    eval "$(dircolors -b)"
  fi


	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi


if ${use_color} ; then

  # Set colorful PS1 only on colorful terminals.
  if [[ ${EUID} == 0 ]] ; then
    PS1='\[\033[01;31m\]\h\[\033[01;34m \w\n\$\[\033[00m\] '
  else
    PS1='\D{W%V.%u %a %b %d, }\t @\s-\v \[\033[01;32m\]\u@\h\[\033[01;37m\]:\w/\[\033[01;32m\]\n\$\[\033[00m\] '

  fi

else
  # show root@ when we don't have colors
  if [[ ${EUID} == 0 ]] ; then
    PS1='\u@\h \W \$ '
  else
    PS1='\u@\h \w \$ '
  fi
fi

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


## for color and non-color terminals, as well as shells that don't
## understand sequences such as \h, don't put anything special in it.
#PS1="${USER:-$(whoami 2>/dev/null)}@$(uname -n 2>/dev/null) \$ "

# \u: current username
# \h: hostname up to the first ., \H: full hostname
# \w: current working directory, \W: same, but only the basename
# $(__git_ps1 "%s"): your current git branch if you're in a git directory, otherwise nothing
# \$: if the effective UID is 0: #, otherwise $
# \d: the date in "Weekday Month Date" format (e.g., "Tue May 26")
# \t: the current time in 24-hour HH:MM:SS format, \T: same, but 12-hour format, \@: same, but in 12-hour am/pm format
# \n: newline
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
# example: \[\e[0;33m\]prompt:\[\e[0m\]


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi



extr() {
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
      *.Z)    c='uncompress';;
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

function gc { git clone --recursive $1; }

function xrpm() { rpm2cpio "$1" | cpio -idmv; }

function mcd(){ mkdir "$1"; cd "$1"; }

# ex - archive extractor
# usage: ex <file>
ex ()
{
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


# extra backslash in front of \$ to make bash colorize the prompt
#PS1='\u@$(hostname):$( printf "%s" "${PWD/${HOME}/~}")\n\$ '
#PS1='\u@$( printf "%s" "${PWD/${HOME}/~}") \$\n\n'
# man bash, PROMPTING

# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

#term
#/etc/terminfo/*
#export TERM="xterm-color"
#export TERM="xterm-256color"
#export TERM=rxvt
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

match_lhs=""
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -f $HOME/.dir_colors ]] && match_lhs="${match_lhs}$(<$HOME/.dir_colors)"
[[ -z ${match_lhs} ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# Change the window title of X terminals
case ${TERM} in
  [aEkx]term*|rxvt*|gnome*|konsole*|interix)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    TITLEBAR='\[\e]0;\u@\h:\w ${NEW_PWD}\007\]'
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"' ;;
    PROMPT_COMMAND='printf "%b" "\033]0;${PWD/$HOME/~}\007"' ;;
  screen*)
    PS1='\[\033k\u@\h:\w\033\\\]'
    #PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"' ;;
    PROMPT_COMMAND='printf "%b" "\033_${PWD/$HOME/~}\033\\"' ;;
  *)
    unset PS1
    TITLEBAR=""
    ;;
esac

PS1="${BLUE}\D{W%V.%u %m%d} \t ${ON_YELLOW}\u@\h${GREEN}:\w/${NORMAL}\n\$ "

export LS_COLORS
# guideline 0: those not in command-not-found
# guideline 1: standard cross-platform parameters, such as ps, tar.

# Alias definitions.
#If these are enabled they will be used instead of original
#To override alias instruction use a \ before, ie \rm will call the real rm

# use a different file for aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Specific bashrc
[[ -f $HOME/.bashrc.local ]] && . $HOME/.bashrc.local

# Docker
[ -f ~/.bashrc_docker ] && .  ~/.bashrc_docker

#Functions
#different file for functions
if [ -f "${HOME}/.bash_functions" ]; then
  source "${HOME}/.bash_functions"
fi

##startup programs ----------------------------------------
#export calendar=~/.calendar/calendar.all

#! ps aux | grep -q fetchmail && fetchmail &
#! ( ps aux | grep -q fetchmail ) && fetchmail &


if [ ! $DISPLAY ] ; then
  if [ "$SSH_CLIENT" ] ; then
  export DISPLAY=`echo $SSH_CLIENT|cut -f1 -d\ `:0.0
  fi
fi


# Start X if login from the first console.
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
    # now use nodm, comment out
#if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
    #startx
    #startxfce4
#fi

# If running trom tty
if [ $(tty) == "/dev/tty3" ]; then
	sway
	exit 0
fi


#For properly registering the ConsoleKit session, you probably want to add --with-ck-launch with startxfce4
#By default xfce4-session tries to start the gpg- or ssh-agent. To disable this run the following commands:
#xfconf-query -c xfce4-session -p /startup/ssh-agent/enabled -n -t bool -s false
#xfconf-query -c xfce4-session -p /startup/gpg-agent/enabled -n -t bool -s false

#To force the ssh-agent instead of the gpg-agent use the following command:
#xfconf-query -c xfce4-session -p /startup/ssh-agent/type -n -t string -s ssh-agent

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs sh
unset color_prompt force_color_prompt

# vim: filetype=sh

export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5

