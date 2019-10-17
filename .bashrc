# ~/.bashrc: executed by bash(1) for non-login shells. ??

# ~/.bashrc: executed by bash(1) for interactive shells.

# Modifying /etc/skel/.bashrc directly will prevent
# setup from updating it.

# Shell is non-interactive.  Be done now!
[[ $- != *i* ]] && return

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


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


########################################
#Shell Options
#See man bash for more options...

#Don't wait for job termination notification
set -o notify


#http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
[ "${BASH_VERSINFO}" -ge "4" ] && shopt -s autocd cdspell dirspell

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# cdspell

# Use case-insensitive filename globbing
# shopt -s nocaseglob
#
# Make bash append rather than overwrite the history on disk
# shopt -s histappend
#
# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell
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

## Detect `$-`, instead of `PS1`
##[ -z "${PS1}" ]



#$ tty
#/dev/ttys003
#$ uname -a
#Darwin Mato.local 14.0.0 Darwin Kernel Version 14.0.0: Fri Sep 19 00:26:44 PDT 2014; root:xnu-2782.1.97~2/RELEASE_X86_64 x86_64

stty -ctlecho #don't show ^C when pressing Ctrl+C

#if [ "`locale charmap 2>/dev/null`" = "UTF-8" ]
#then
  #stty iutf8
#fi


# if no "-" , .profile won't be loaded??
# such as in "su -", or "mintty -"

## Use case-insensitive filename globbing
# shopt -s nocaseglob

# Bash won't get SIGWINCH if another process is in the foreground.
# Check terminal size when it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't use ^D to exit
#set -o ignoreeof  # Same as setting IGNOREEOF=10
#IGNOREEOF=10    # Shell only exists after the 10th consecutive Ctrl-d
#set ignoreeof  # prevent accidental shell termination

# sometimes, stty eof '^D' / stty eof undef
#export IGNOREEOF=2
IGNOREEOF=2

########################################
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

# $HOME/.bashrc
#bind '"\e[A": history-search-backward'
#bind '"\e[B": history-search-forward'
#Normally, Up and Down are bound to the Readline functions previous-history and
# next-history respectively. I prefer to bind PgUp/PgDn to these functions,
# instead of displacing the normal operation of Up/Down.

# To get the escape codes for the arrow keys you can do the following:
#Start cat in a terminal (just cat, no further arguments).
#Type keys on keyboard, you will get ^[[A for up arrow and ^[[B for down arrow.
#Replace ^[ with \e.
bind "set match-hidden-files off"     #don't match hidden files
bind "set bind-tty-special-chars on"  #punctuations are not word delimiters

#ctrl-RIGHT got 5C


### history

# append to the history file, don't overwrite it
shopt -s histappend
shopt -s histverify

#Don't put duplicate lines in the history.
# Keep also space-starting lines, just in case
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#HISTCONTROL=ignoreboth
#HISTCONTROL=ignoredups:ignorespace
# See bash(1) for more options
# HISTCONTROL=ignoredups

#Ignore some controlling instructions
#HISTIGNORE is a colon-delimited list of patterns which should be excluded.
#The '&' is a special pattern which suppresses duplicate entries.
HISTIGNORE=$'[ \t]*:&:[fb]g:pwd:date:exit:ls'
#HISTIGNORE="[ \t]*:&:[fb]g:pwd:date:exit:* --help"

HISTIMEFORMAT="%F %T"

#Whenever displaying the prompt, write the previous line to disk
# to keep history even after abnormal bash quit,
# This does mean sessions get interleaved when reading later on, but this
# way the history is always up to date.  History is not synced across live
# sessions though; that is what `history -n` does.
# Disabled by default due to concerns related to system recovery when $HOME
# is under duress, or lives somewhere flaky (like NFS).  Constantly syncing
# the history will halt the shell prompt until it's finished.
# export PROMPT_COMMAND="history -a"
# PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# #PROMPT_COMMAND='history -a $HOME/.bash_history; echo -ne "\033]0;$PWD\007"; $PROMPT_COMMAND;'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=60000

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


########################################
# colorful
unset color_prompt force_color_prompt

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


# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
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
NORMAL="\[\e[0m\]"

# Setup a red prompt for root and a green one for users.
RED="\[\e[1;31m\]"
GREEN="\[\e[1;32m\]"
if [[ $EUID == 0 ]] ; then
  PS1="$RED\u [ $NORMAL\w$RED ]# $NORMAL"
else
  PS1="$GREEN\u [ $NORMAL\w$GREEN ]\$ $NORMAL"
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it is compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
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


# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


# Term
#/etc/terminfo/*
# This directory is for system-local terminfo descriptions. By default,
# ncurses will search ${HOME}/.terminfo first, then /etc/terminfo (this
# directory), then /lib/terminfo, and last not least /usr/share/terminfo.

#export TERM="xterm-256color"
#export TERM=screen-256color
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# Set the window title of X terminals
case ${TERM} in
    # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
    # If this is an xterm set the title to user@host:dir
  [aEkx]term*|rxvt*|gnome*|konsole*|interix)
    color_prompt=yes
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    TITLEBAR='\[\e]0;\u@\h:\w ${NEW_PWD}\007\]'
    ;;
  screen*)
    #PROMPT_COMMAND='printf "%b" "\033]0;${PWD/$HOME/~}\007"' ;;
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\033\\"'
    # PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
    ;;
esac


# extra backslash in front of \$ to make bash colorize the prompt
#PS1='\u@$(hostname):$( printf "%s" "${PWD/${HOME}/~}")\n\$ '
# man bash, PROMPTING

# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

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

# Obseleted!!
# enable color support of ls and also add handy aliases

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


match_lhs=""
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -f $HOME/.dir_colors ]] && match_lhs="${match_lhs}$(<$HOME/.dir_colors)"
[[ -z ${match_lhs} ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true


export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
#export LS_COLORS
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

# guideline 0: those not in command-not-found
# guideline 1: standard cross-platform parameters, such as ps, tar.

# Specific bashrc
[[ -f $HOME/.bashrc.local ]] && . $HOME/.bashrc.local

# Docker
[ -f ~/.bashrc_docker ] && .  ~/.bashrc_docker

#Functions
#different file for functions
if [ -f "~/.bash_functions" ]; then
  source "~/.bash_functions"
fi


# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs sh
unset color_prompt force_color_prompt

unset -f have
unset UNAME RELEASE default dirnames filenames have nospace bashdefault plusdirs
set notildeop


# Functions

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


function vack {
  # apt-get install ack-grep
  vim `ack-grep -g $@`
}

mdcd() {
  mkdir -p "$1" && cd "$1"
}


#function settitle
settitle ()
{
  echo -ne "\e]2;$@\a\e]1;$@\a";
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
  To run a command as administrator (user "root"), use "sudo <command>".
  See "man sudo_root" for details.

EOF
    fi
  esac
fi


########################################
## Timezone
TZ='Asia/Shanghai'; export TZ


########################################
# locale
# export LANGUAGE="zh_CN:zh:en"
#export LANGUAGE=en_US.UTF-8
# export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Dont clear the screen after quitting a manual page
export MANPAGER="less -X"
## less not as chinese pager
export LESSCHARSET=utf-8


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


### PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# NEVER export PATH without quoting $PATH
# Deal with PATH only in .bashrc, and source it in ~/.bash_profile
# Original PATH is set in /etc/profile

#For Java
# export JAVA_HOME=/usr/lib/jvm/java-6-sun-1.6.0.14/jre/
# [ ! -z $JAVA_HOME ] && export PATH=$JAVA_HOME/bin:$PATH
# export CLASSPATH=$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/td.jar:$JAVA_HOME/lib/rt.jar:.
#export PATH=$JAVA_HOME/bin:/$HOME/.local/my-cross/bin:$PATH

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

export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/share/lib:/usr/local/lib:/usr/X11R6/lib:/opt/lib
export LD_LIBRARY_PATH=/opt/j2sdk1.4.2_04/jre:$LD_LIBRARY_PATH

###Heroku Toolbelt
[ -d "$HOME/.local/heroku/bin" ] && export PATH="$HOME/.local/heroku/bin:$PATH"

[ -d "/snap/bin" ] && export PATH="/snap/bin:$PATH"

###Go
[ -d "$HOME/.cargo/bin" ] && export PATH="$HOME/.cargo/bin:$PATH"

#perl5
[ -d "$HOME/.local/perl5/bin" ] && export PATH="$HOME/.local/perl5/bin${PATH:+:${PATH}}";
PERL5LIB="$HOME/.local/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="$HOME/.local/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"$HOME/.local/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl5"; export PERL_MM_OPT;

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

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

# Dont clear the screen after quitting a manual page
export MANPAGER="less -X"
## less not as chinese pager
export LESSCHARSET=utf-8

#eval "$(lessfile)"
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
#export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/share/lib:/usr/local/lib:/usr/local/share/lib:/usr/X11R6/lib:/opt/lib

export PATH


# export BBSHOME="/home/bbs"
# export WWWHOME="/home/bbs/www"
# export PHPHOME="/home/bbs/www/php"
# export SRCDIR="/home/"

# Original PATH is set in /etc/profile
# NEVER export PATH without quoting $PATH

#never
## [ "$UID" = "0" ] || export PATH=".:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export EDITOR=vim
# export INPUTRC=/etc/inputrc
export USER LOGNAME MAIL HOSTNAME
export VISUAL=$EDITOR
export CSCOPE_EDITOR="$EDITOR"
export WCDHOME="${HOME}/.wcd"
#export BROWSER="chromium"
export BROWSER="x-www-browser"

# export RESIN_HOME

export SHLVL=1
export G_BROKEN_FILENAMES=1

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export PATH

# if ! -z $CROSS_
# export CROSS_COMPILE=ppc_85xx-
# export TARGET_OS=linux


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

shopt -s checkhash cmdhist expand_aliases histreedit mailwarn
shopt -s hostcomplete


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


# Completion options
#These completion tuning parameters change the default behavior of bash_completion:
#
#Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1

#Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1

# source user completion file
#[ $BASH_COMPLETION != ~/.bash_completion -a -r ~/.bash_completion ] && . ~/.bash_completion

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

#trap '. /etc/bash_completion ; trap USR2' USR2
#{ sleep 0.01 ; builtin kill -USR2 $$ ; } & disown
#[ -z "${BASH_COMPLETION_COMPAT_DIR}" ] && [ -f /etc/bash_completion ] && . /etc/bash_completion

#   https://github.com/scop/bash-completion

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

complete -W menuconfig make
complete -cf sudo

#[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && . $HOME/.autojump/etc/profile.d/autojump.sh


#FIXME
#certutil: function failed: SEC_ERROR_PKCS11_GENERAL_ERROR: A PKCS #11 module returned CKR_GENERAL_ERROR, indicating that an unrecoverable error has occurred.

##startup programs ----------------------------------------
#export calendar=$HOME/.calendar/calendar.all

#! ps aux | grep -q fetchmail && fetchmail &
#! ( ps aux | grep -q fetchmail ) && fetchmail &

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


# if the command-not-found package is installed, use it
if [ -x /usr/lib/command-not-found ]; then
  function command_not_found_handle {
  # check because c-n-f could've been removed in the meantime
  if [ -x /usr/lib/command-not-found ]; then
    /usr/lib/command-not-found -- "$1"
    return $?
  else
    printf "%s: command not found\n" "$1" >&2
    return 127
  fi
  }
fi

# only in Util-Linux; not work for BSD
#setterm -blength 0


export QT_STYLE_OVERRIDE=gtk
export QT_SELECT=qt5


# Alias definitions.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
#If these are enabled they will be used instead of original
#To override alias instruction use a \ before, ie \rm will call the real rm
# use a different file for aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


# Start X if login from the first console.
#[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
    # now use nodm, comment out
#if [ "$(tty)" = "/dev/tty1" -o "$(tty)" = "/dev/vc/1" ] ; then
    #startx
    #startxfce4
#fi

if [ ! $DISPLAY ] ; then
  if [ "$SSH_CLIENT" ] ; then
  export DISPLAY=`echo $SSH_CLIENT|cut -f1 -d\ `:0.0
  fi
fi

# If running trom tty
if [ $(tty) == "/dev/tty3" ]; then
  sway
  exit 0
fi


##PS1 ----------------------------------------
unset PS1
TTY=$(tty)
TTY=${TTY##*/}

##bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
#if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor

#PS1=$BYellow"@$TTY@\\s-\\v "$Cyan$PS1
#PS1='\u@$(hostname):$( printf "%s" "${PWD/${HOME}/~}")\n\$ '
PS1="${ON_YELLOW}\u@\h${GREEN}:\w/${NORMAL}$(__git_ps1)\n\$ "
PS1="$BGreen\D{W%V.%u %m%d} $UPurple\t$NORMAL $BBlue"$PS1$NORMAL

#eval `keychain --eval --agents ssh id_rsa`
#eval `keychain --eval ~/.ssh/id_dsa`
#eval `keychain --eval ~/.ssh/id_rsa`

# curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o repo
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

function count {
  I=$1
  while [ $I -le $2 ];
    do echo $I
    I=$((I+1))
  done
}

function defaultps1() {
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\u@\h:\w\$ '
}
defaultps1 # call it

TITLEBAR_PREFIX=""
function titlebar {
  TITLEBAR_PREFIX="$*"
  echo -ne "\033]2;$*\a"
}

function color() {
  tput setf $1
}
function nocolor() {
  tput sgr0
}

function gitps1() {
  PROMPT_COMMAND=gitps1

  if ! git root >/dev/null 2>&1; then
    defaultps1
    return
  fi

  B=$(git curbr)
  U=$USER
  R=$(basename $(git root))
  H=$(hostname | cut -f1 -d.)
  W=$(realpath . | sed "s|$(git root)/\?|/|")

  #TODO: abstract the prefix, which sets titlebar and is duplicated
  #TODO: with defaultps1
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\[$(color 6)\]$U@$H \[$(color 1)\]$R \[$(color 3)\]$B \[$(color 6)\]$W\[$(nocolor)\]\$ '
}

export PRINTER=tahiti-color
export PRINTER2=waikiki-color
export ENV=$HOME/.bashrc

export PATH=~/src/go/bin:/usr/local/go/bin:$PATH
export GOPATH=~/src/go
function KUBEGOPATH {
  export GOPATH=`pwd`/Godeps/_workspace:`pwd`/_output/local/go:$GOPATH
}

