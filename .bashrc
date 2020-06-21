# ~/.bashrc: executed by bash(1) for interactive shells.
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

# To enable the settings / commands in this file for login shells as well,
# this file has to be sourced in profile.

# if no "-" , .profile won't be loaded??
# such as in "su -", or "mintty -"

# Modifying /etc/skel/.bashrc directly will prevent setup from updating it.

# some ... shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !

##[ -z "${PS1}" ]
# Shell is non-interactive. Be done now!
[[ $- != *i* ]] && return

#QUOTE BEGIN
    ## System-wide .profile for sh(1)

    #if [ -x /usr/libexec/path_helper ]; then
        #eval `/usr/libexec/path_helper -s`
    #fi

    #if [ "${BASH-no}" != "no" ]; then
        #[ -r /etc/bashrc ] && . /etc/bashrc
    #fi
#QUOTE END


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi

if [[ "`uname -s`" == "FreeBSD" ]]
#if [[ "$OSTYPE" =~ *BSD ]]; then
then
  alias ls='\ls -FG'
elif [[ "$OSTYPE" =~ ^darwin ]]; then
#elif [ "`uname -s`" == "Darwin" ]
	# uname also works
  alias ls="command ls -bFG"
else # Assume Linux
  #alias ls="command ls -FG"
  alias ls='\ls -F -X --show-control-chars'
  #alias ls='\ls -F -X --color=tty --show-control-chars'
  export LS_COLORS='no=00:fi=00:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
fi

# Obseleted!!
# enable color support of ls and also add handy aliases
# eval "`dircolors -b`"

# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.

# guideline 0: those not in command-not-found
# guideline 1: standard cross-platform parameters, such as ps, tar.

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    # Never use 'grep --colour=always', control characters apply!
    alias grep='grep --color=auto --exclude-dir=.git -s -I'
fi

# For dircolors-solarized
# - https://github.com/seebi/dircolors-solarized

export LS_OPTIONS='--color=auto'
export CLICOLOR='Yes'
# for ls colors
LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:"
export LS_COLORS

export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD

use_color=false


match_lhs=""
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -f $HOME/.dir_colors ]] && match_lhs="${match_lhs}$(<$HOME/.dir_colors)"
[[ -z ${match_lhs} ]] && type -P dircolors >/dev/null && match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

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


########################################
# colorful
unset color_prompt force_color_prompt
color_prompt=yes
force_color_prompt=yes

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
NORMAL="\[\e[0m\]"

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




# Alias
## translate
#alias u='translate -i'

#-C										list entries by columns
#-F, --classify                append indicator (one of */=>@|) to entries
#-F      Display a slash (`/') immediately after each pathname that is a directory,
#        an asterisk (`*') after each that is executable,
#        an at sign (`@') after each symbolic link,
#        an equals sign (`=') after each socket,
#        a percent sign (`%') after each whiteout, and
#        a vertical bar (`|') after each that is a FIFO.

# alias l='ls -ah --color'
alias l='ls'
alias la='ls -A'
alias ll='ls -lh --color=tty'                 # classify files in colour
#-a, --all						do not ignore entries starting with .
#-A, --almost-all			do not list implied . and ..
# List all files colorized in long format, including dot files
alias l.='ls -Al'
alias ldir='\ls -al | egrep ^d'
# vi `lf`
alias lf="ls . -rt1 | tail -1"
alias lh='ls -A | egrep "^\."'
alias lS='ls -lS'
alias lSr='ls -lSr'
alias lt='ls -ltA'
alias ltr='ls -ltAr'

alias ..='cd ..'

alias N='&>/dev/null'
alias '...'='../..'
alias '....'='../../..'
alias BG='& exit'
alias C='|wc -l'
alias G='|grep'
alias H='|head'
alias Hl=' --help |& less -r'
alias K='|keep'
alias L='|less'
alias LL='|& less -r'
alias M='|most'
alias N='&>/dev/null'
alias R='| tr A-z N-za-m'
alias SL='| sort | less'
alias S='| sort'
alias T='|tail'
alias V='| vim -'

alias cd..="cd .."

alias cp='cp -i -v -a'

# -a = -pPR
#  -R If source_file designates a directory, cp copies the directory and the entire subtree connected at that point.  If the source_file ends in a /, the
#     contents of the directory are copied rather than the directory itself.  This option also causes symbolic links to be copied, rather than indirected
#     through, and for cp to create special files rather than copying them as normal files.  Created directories have the same mode as the corresponding
#     source directory, unmodified by the process' umask.
#
#     In -R mode, cp will continue copying even if errors are detected.
#
#     Note that cp copies hard-linked files as separate files.  If you need to preserve hard links, consider using tar(1), cpio(1), or pax(1) instead.

alias chmod='chmod -v'
which colordiff &>/dev/null && alias diff='colordiff'
[ which colormake >/dev/null 2>&1 ] && alias make=colormake
alias crontab='crontab -i'
alias cv='convmv -f gbk -t utf-8 -r --notest'

#alias curl="curl --user-agent 'noleak'"
alias curl="curl --user-agent 'noleak'"
alias curl='curl -L -C'
alias curl='curl -L -C -'

alias dd="dd bs=8M status=progress"
alias debug_on="sed -i 's/^\/\/#define LOG_NDEBUG 0/#define LOG_NDEBUG 0/g' "
alias debug_off="sed -i 's/^#define LOG_NDEBUG 0/\/\/#define LOG_NDEBUG 0/g' "
# debug_on MediaExtractor.cpp
# debug_off *.*

alias df='df -h -T | grep -v tmpfs'
alias diff='diff -x.git'
alias dl='dpkg -L'
alias dlg='dpkg -l | grep'
alias dlc='dlocate -i'
alias docker-pid="sudo docker inspect --format '{{.State.Pid}}'"
alias docker-ip="sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
alias ds='dpkg -s'
alias du.='du -h --max-depth=1 | sort -hr'

alias emerge='emerge -avt'
alias eng='env | grep -i'
alias enprint='enscript -h -G -E -2 -r --rotate-even-pages -DDuplex:true'
alias equo='equo --color --ask -v'
alias es='emerge --search'
#alias expemerge="ACCEPT_KEYWORDS=\"~x86\" emerge"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
# program 'notify-send' is in libnotify-bin


alias a='alias'
#alias adb='adb wait-for-device'
alias adbw='adb wait-for-device'

alias acs='apt-cache search'
alias asrm='adb shell rm'
alias adbw='adb wait-for-device'
alias asrmr='adb shell rm -r'
alias auru='yaourt -Syua --noconfirm'

alias bb='bitbake -v'

alias c='clear'
alias cp='\cp -i -v -a'
# -a = -pPR
#  -R If source_file designates a directory, cp copies the directory and the entire subtree connected at that point.  If the source_file ends in a /, the
#     contents of the directory are copied rather than the directory itself.  This option also causes symbolic links to be copied, rather than indirected
#     through, and for cp to create special files rather than copying them as normal files.  Created directories have the same mode as the corresponding
#     source directory, unmodified by the process' umask.
#
#     In -R mode, cp will continue copying even if errors are detected.
#
#     Note that cp copies hard-linked files as separate files.  If you need to preserve hard links, consider using tar(1), cpio(1), or pax(1) instead.


alias file="file -k"
alias fn="find -iname"
alias fsg='find . -name .git -prune -o -print | xargs grep -H -I -s --colour=auto'
# search for a string in all subdirectories, matched lines will be printed together with filename and line number.
alias finds='find . -regex ".*\.\(h\|cpp\|c\|java\|aidl\|py\|pl\|pm\)" | xargs grep -Hn'
# case insensitive search.
alias findsi='find . -regex ".*\.\(h\|cpp\|c\|java\|aidl\|py\|pl\|pm\)" | xargs grep -Hni'
alias findgrep="find . -print0 | xargs -0 grep"

# git
alias gits='git status --ignore-submodules=dirty'

# git reset --hard `gitorigin`
#alias gitorigin="git branch -r | head -1 | cut -d' ' -f 5"
alias gor="git branch -r | head -1 | cut -d' ' -f 5"
alias ga="git add"
alias gap="git add --patch"
alias gb='git branch -vv'
alias gca='git commit --amend'
alias gcl='git clone -v --recursive'
# as function: git clone --recursive $1
alias gcv='git commit --no-verify'
alias gd="git diff --patience --ignore-space-change"
alias gdc='git diff --cached -w'
alias gdw='git diff --no-ext-diff --word-diff'
alias gdv='git diff -v'
alias gf='git fetch -a -p'
alias gg="git log --abbrev=10 --graph --all --format='%C(auto)%h%d %C(auto,bold black)<%C(reset)%C(auto,blue)%aE%C(auto,bold black)>%C(reset) %s %C(auto,bold black)(%C(reset)%C(auto,green)%ar%C(auto,bold black))%C(reset)'"
alias gg="git log --abbrev=10 --graph --format='%C(auto)%h%d %C(auto,bold black)<%C(reset)%C(auto,blue)%aE%C(auto,bold black)>%C(reset) %s %C(auto,bold black)(%C(reset)%C(auto,green)%ar%C(auto,bold black))%C(reset)'"
alias gg="git log --abbrev=10 --color --all --graph --pretty=format:\"%h %ad %an %s%d\" --date=iso"
alias gg='git grep -a -i'
alias gup='git pull --rebase --prune && git submodule update --init --recursive'
alias gi="git commit -v"
alias g='echo; git log -n 12 --graph --oneline --decorate; echo; git status --ignore-submodules=dirty; echo'
alias gl="git log --abbrev=10 --pretty=format:\"%Cgreen%h%Creset %Cblue%ad%Creset %s%C(yellow)%d%Creset %Cblue[%an]%Creset\" --graph --date=iso"
alias gl='git log --abbrev=10 --oneline --decorate --graph'
alias glp='git log -p'
alias glss='git log --abbrev=10 --stat'
alias gmb="git merge-base"
alias gpa='for i in `git remote | grep -v upstream`; do echo; echo To remote $i ......; echo; git push $i;done'
alias gpp='git pull --rebase && git push'
alias gr="git remote -v"
alias grss="git remote show origin"
alias gpr='git pull --rebase --recurse-submodules'

alias gss='git show --stat'
#alias gst='git status --ignore-submodules=dirty'
alias gst='git status -suno --ignore-submodules=dirty && git branch -vv'

alias gup='git pull --rebase --prune && git submodule update --init --recursive'
alias gsl='git stash list'
alias gss='git stash save'

alias gdb='gdb -q'

alias cg='grep -in --color -I'
alias cgr='grep -in --color -rI'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grpe=grep
alias gerp=grep

alias hig='history | grep'
alias info='info --vi-keys'
alias jobs="jobs -l"
alias jq="jq -C -S"
alias ka="killall"

alias mpl='mplayer -vf screenshot -msgcolor'
alias mm="make menuconfig"
alias ms='gpm -m /dev/psaux -t imps2'
#alias mt='mlterm -ls -sl 5000 -bg black -fg grey80 -A &'
alias mt='mlterm -ls -sl 5000 -bg black -fg grey80 -A -geometry 125x43+0+0 &'
alias lc='locate -i'
alias less='less -r'                          # raw control characters

alias make='make -j4'
alias mm="make menuconfig"
alias moer=more
alias mplayer='mplayer -vf screenshot -msgcolor'
alias mpv="mpv --audio-display=no"
alias ms='gpm -m /dev/psaux -t imps2'
#alias mutt='mutt -y'
alias m=mutt
alias mv='mv -i'
#alias mt='mlterm -ls -sl 5000 -bg black -fg grey80 -A &'
alias mt='mlterm -ls -sl 5000 -bg black -fg grey80 -A -geometry 125x43+0+0 &'
alias mo=more
alias moer=more
alias mroe=more

alias nano='nano -i -m -w -B -F -L'
alias nano='nano -i -m -w -B -F -L -xcSr68'
alias netstat='netstat -an'
alias np='nano -w PKGBUILD'

alias open='xdg-open'

alias pacman='sudo pacman -v'
alias pacrepo='sudo reflector -l 20 -f 10 --save /etc/pacman.d/mirrorlist'
alias pacr='sudo pacman -Rs'
alias pacu='sudo pacman -Syu --noconfirm'
alias pcmanfm='pcmanfm -d --desktop'
#alias pix='for i in *.jpg; do convert -quality 50% "$i" "$i"; done'
alias po="popd"
alias pu="pushd"
alias rp='realpath'
alias ps='ps auxwf'

alias pS='sudo pacman -S'
alias pss='pacman -Ss'
#alias psg='ps -Af | grep $1'
alias psg='\ps aux | grep -v without-match | grep'
alias pqg='pacman -Q|egrep -i'
alias pqi='pacman -Qi'
alias pql='pacman -Ql'
alias pqo='pacman -Qo'
alias pacrf='sudo pacman -Rns'
alias pS='sudo pacman -S'
alias pss='pacman -Ss'
alias py="python2"

#if type pgrep &>/dev/null; then xxx; fi
which pgrep &>/dev/null && alias pgrep='ps -C polkitd -o pid='

alias rpi='rpm -qi'
alias rx='LANG=zh_CN.GB2312 LC_CTYPE=zh_CN.GB2312 rxvt -ls -sl 500 -fn 8x16 -bg black -fg grey80 -ls&'
alias rpg='rpm -qa | grep'
#alias rename='perl-rename'
alias rmbra="rename 'y/)(/_/'"
alias rsync='rsync -av --progress'
# acct - The GNU Accounting utilities for process and login accounting
# surfraw - a fast unix command line interface to WWW
alias scp='scp -r'
alias sdr='sudo rm -r'
alias se='ls /usr/bin | grep'
alias shred="shred -zf"
alias sls='screen -ls'
# acct - The GNU Accounting utilities for process and login accounting
# surfraw - a fast unix command line interface to WWW
alias sr='screen -r'
alias ssh='ssh -v -o VisualHostKey=yes -o ServerAliveInterval=30 -o StrictHostKeyChecking=yes'
## ignore ~/.ssh/known_hosts entries
#alias insecssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null" -o "PreferredAuthentications=keyboard-interactive"'
alias svi='sudo vi'

alias tmars='telnet 210.77.17.19 1012'

# alias tail='tail -f'
alias tmux='tmux -2'
#alias ta='tmux a -d'
alias tad='tmux a -d'
alias tou8='iconv -f gbk -t utf-8'

alias ua='uname -a'
# Disabled because some version has no this option
# UnZip 6.00 of 20 April 2009, by Debian. Original by Info-ZIP.
# alias unzip='unzip -O CP936'

alias vd="vimdiff"
#alias vim="vim -p"
which nvim &>/dev/null && alias vd="nvim -d"
which nvim &>/dev/null && alias nv="nvim -p"
alias vi="vim -p"


# Undo a `git push`
alias undopush="git push -f origin HEAD^:master"

# IP addresses
alias digip="dig +short myip.opendns.com @resolver1.opendns.com"
## TODO
alias localip="ipconfig getifaddr en1"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"
alias ips="ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print $1'"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# Start an HTTP server from a directory
alias server="python2 -m SimpleHTTPServer"
alias server="python2 -m SimpleHTTPServer 8080"
alias server='python2 -c "import SimpleHTTPServer;SimpleHTTPServer.test()"'
alias server="python3 -m http.server 8080"
alias server="python3 -m http.server"

# Trim new lines and copy to clipboard
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias copy='xclip -selection clipboard'
alias yank='xclip -selection clipboard -o'

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias C="tr -d '\n' | pbcopy"


alias pacrepo='sudo reflector -l 20 -f 10 --save /etc/pacman.d/mirrorlist'
alias pacu='sudo pacman -Syu --noconfirm'
alias auru='yaourt -Syua --noconfirm'
alias fe='find /sbin /bin /usr/sbin /usr/bin | grep'

alias hs='history | tail -40 | more'
alias tcs='ctags -R --fields=+lS . ; cscope -Rbq'

#bsd
export PACKAGEROOT=ftp://ftp.freebsdchina.org
# export PACKAGESITE

# Canonical hex dump; some systems have this symlinked
[ -n "$ZSH_VERSION" ] && type hd > /dev/null || alias hd="hexdump -C"
[ "$BASH_VERSINFO" -ge "4" ] && type -t hd > /dev/null || alias hd="hexdump -C"

# source '~/google-cloud-sdk/path.bash.inc'

alias scu='systemctl --user'
alias journ='sudo journalctl -b -f'
alias poweroff='sudo systemctl poweroff'
alias reboot='sudo systemctl reboot'
alias suspend='sudo systemctl suspend'

alias lsblk='lsblk -o NAME,FSTYPE,SIZE,MOUNTPOINT,LABEL,UUID'
alias strc="awk '!/^ *#/ && NF'"
alias dmesg='clear; dmesg -eL -w'

# Go
alias sv='source ~/.config/vim/scripts/gb.bash sv'


# Canonical hex dump; some systems have this symlinked
type -t hd > /dev/null || alias hd="hexdump -C"

# OS X has no `md5sum`, so use `md5` as a fallback
type -t md5sum > /dev/null || alias md5sum="md5"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# File size
alias fs="stat -f \"%z bytes\""

alias dos2unix='perl -pi -e "tr/\r//d"'
alias unix2dos='perl -pi -e "s/\n$/\r\n/g"'
alias mac2unix='perl -pi -e "tr/\r/\n/d"'

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'

# One of @janmoesen’s ProTip™s
for method in GET HEAD POST PUT DELETE TRACE OPTIONS; do alias "$method"="lwp-request -m '$method'"; done

# Stuff I never really use but cannot delete either because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

# PostgreSQL
alias start-psql="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias stop-psql="pg_ctl -D /usr/local/var/postgres stop -s -m fast"


#alias wget="wget --no-check-certificate -c --content-disposition"
alias wget="wget -U 'noleak'"
alias wget="wget -U User-Agent -c --content-disposition"
alias whence='type -a'                        # where, of a sort
alias where="type -all"
alias which='alias | which -a'
#alias which="type -path"
#alias which='alias | which --tty-only --read-alias --show-dot --show-tilde'
alias whois="whois -h whois-servers.net"
alias wt='curl http://wttr.in/'

# Byzanz requires a 24bpp or 32bpp depth for recording.
#alias xx='startx -- -nolisten tcp -depth 24'
alias xx='startx -- -nolisten tcp -depth 24 -extension GLX'
alias xfb='startx -- -nolisten tcp -fbbpp 24'
alias x1='startx -- :1 -depth 32'
alias x2='startx -- :2 -depth 32'
alias yum='yum -v -y --color=auto'
alias xorpsh='su xorp -p -c xorpsh'


########################################
#Shell Options
#See man bash for more options...

#Don't wait for job termination notification
set -o notify

#http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
[ "${BASH_VERSINFO}" -ge "4" ] && shopt -s autocd cdspell dirspell

# Use case-insensitive filename globbing
# shopt -s nocaseglob

# When changing directory small typos can be ignored by bash
# for example, cd /vr/lgo/apaache would find /var/log/apache
# shopt -s cdspell

#$ tty
#/dev/ttys003
#$ uname -a
#Darwin Mato.local 14.0.0 Darwin Kernel Version 14.0.0: Fri Sep 19 00:26:44 PDT 2014; root:xnu-2782.1.97~2/RELEASE_X86_64 x86_64

# Bash won't get SIGWINCH if another process is in the foreground.
# Check terminal size when it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't use ^D to exit
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

#Normally, Up and Down are bound to the Readline functions previous-history and
# next-history respectively. I prefer to bind PgUp/PgDn to these functions,
# instead of displacing the normal operation of Up/Down.

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

#Don't put duplicate lines in the history.
# See bash(1) for more options
# Keep also space-starting lines, just in case
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups

#HISTCONTROL=ignoreboth
# HISTCONTROL=ignoredups
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

### history end


# Term
#/etc/terminfo/*
# This directory is for system-local terminfo descriptions. By default,
# ncurses will search ${HOME}/.terminfo first, then /etc/terminfo (this
# directory), then /lib/terminfo, and last not least /usr/share/terminfo.

# It seems setting TERM to xterm-256color in your .bashrc overrides set -g default-terminal "screen-256color" from tmux and that causes issues. This makes sense as bash is running inside tmux and its setting override those from tmux.

# You can easily verify this by running echo $TERM in bash within tmux. With your current setup it will be xterm-256color which is a no-go as Tmux explicitly requires this to be set to screen-256color.

[ -z "$TMUX" ] && export TERM="xterm-256color"
#export TERM=screen-256color
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM

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

# If this is an xterm set the title to user@host:dir

# Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
# Set the window title of X terminals
    # Commented out, don't overwrite xterm -T "title" -n "icontitle" by default.
    # If this is an xterm set the title to user@host:dir
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
    #PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    TITLEBAR='\[\e]0;\u@\h:\w/ ${NEW_PWD}\007\]'
# init it by setting PROMPT_COMMAND
    #PROMPT_COMMAND='printf "%b" "\033]0;${PWD/$HOME/~}\007"' ;;
#PROMPT_COMMAND=bash_prompt_command
  PROMPT_COMMAND=__git_ps1
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"; echo -ne "\007"'


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



function count {
  I=$1
  while [ $I -le $2 ];
    do echo $I
    I=$((I+1))
  done
}

TITLEBAR_PREFIX=""
function titlebar() {
  TITLEBAR_PREFIX="$*"
  echo -ne "\033]2;$*\a"
}

function color() {
  tput setf $1
}
function nocolor() {
  tput sgr0
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
  PS1='\[\e]0;${TITLEBAR_PREFIX} \w\a\]\[$(color 6)\]$U@$H \[$(color 1)\]$R \[$(color 3)\]$B \[$(color 6)\]$W\[$(nocolor)\] \$ '
}

##PS1 ----------------------------------------
# extra backslash in front of \$ to make bash colorize the prompt
# man bash, PROMPTING
  # for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
if ${use_color} ; then
  # Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
  if [[ -f ~/.dir_colors ]] ; then
    eval "$(dircolors -b ~/.dir_colors)"
  elif [[ -f /etc/DIR_COLORS ]] ; then
    eval "$(dircolors -b /etc/DIR_COLORS)"
  else
    eval "$(dircolors -b)"
  fi

  #gpg
  #export GPGKEY=""
  #export GPG_TTY="$(tty)"

  TTY=$(tty)
  TTY=${TTY##*/}

  #PS1='\u@$(hostname):$( printf "%s" "${PWD/${HOME}/~}")/\n\$ '
    PS1='$(titlebar)\u@\h:\w/\n\$ '
  PS1="$BGreen\D{W%V.%u %m%d} \T$(__git_ps1) $NORMAL"$PS1

else
  PS1='\u@\h \w \$ '
fi


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
## less not as chinese pager
export LESSCHARSET=utf-8

#eval "$(lessfile)"
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# test -r ~/.vim/branch_prompt.sh && source ~/.vim/branch_prompt.sh
# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"


##bash=${BASH_VERSION%.*}; bmajor=${bash%.*}; bminor=${bash#*.}
#if [ "$PS1" ] && [ $bmajor -eq 2 ] && [ $bminor '>' 04 ]
#unset bash bmajor bminor


# guideline 0: those not in command-not-found
# guideline 1: standard cross-platform parameters, such as ps, tar.

# Specific bashrc
[[ -f $HOME/.bashrc.local ]] && . $HOME/.bashrc.local

# Try to keep environment pollution down, EPA loves us.
unset use_color safe_term match_lhs sh
unset color_prompt force_color_prompt

unset -f have
unset UNAME RELEASE default dirnames filenames have nospace bashdefault plusdirs
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


# bring a feature branch back to master
gum() { git checkout "$1" && git rebase master && git checkout master; }

# Show which branches need to be rebased on master, typically after a pull.
# commits listed between a branch and master. Then I know which branches to use with gum.
# The list of excluded branches includes branches which should not be rebased against master (I could do some processing of git branch -r to not have those hardcoded) but the odd one is stale. Sometimes, I get an idea for a feature which is too intrusive, too messy or just too incomplete to be rebased against master. Rather than losing the idea or wasting time rebasing, I'm getting into the habit of renaming the branch foo as stale-foo and gsb then leaves it alone. Equally, there are frequently times when I need to have a feature branch based on another feature branch, sometimes several feature branches deep. Identifying these branches and avoiding rebasing on the wrong branch is important to not waste time.
gsb() { LIST=`git branch|egrep -v '(release|staging|trusty|playground|stale)'|tr '\n' ' '|tr -d '*'`; git show-branch $LIST; }


# Shows which feature branches can be dropped with git branch -d.
gleaf(){ git branch --merged master | egrep -v '(release|staging|trusty|playground|pipeline|review|stale)'; }

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
function mdcd() { mkdir "$1"; cd "$1"; }
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


### PATH
PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# Original PATH is set in /etc/profile
# NEVER export PATH without quoting $PATH
# Deal with PATH only in .bashrc, and source it in ~/.bash_profile

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

[ -d "$HOME/.gem/ruby/bin" ] && export PATH="$HOME/.gem/ruby/bin:$PATH"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

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

# The next line enables bash completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.bash.inc' ]; then
  source '$HOME/google-cloud-sdk/completion.bash.inc'
fi


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

# Disable completion when the input buffer is empty.  i.e. Hitting tab
# and waiting a long time for bash to expand all of $PATH.
shopt -s no_empty_cmd_completion

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Completion options
#These completion tuning parameters change the default behavior of bash_completion:

#Define to avoid stripping description in --option=description of './configure --help'
COMP_CONFIGURE_HINTS=1

#Define to avoid flattening internal contents of tar files
COMP_TAR_INTERNAL_PATHS=1

# source user completion file
#[ $BASH_COMPLETION != ~/.bash_completion -a -r ~/.bash_completion ] && . ~/.bash_completion

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
#if ! shopt -oq posix; then

#trap '. /etc/bash_completion ; trap USR2' USR2
#{ sleep 0.01 ; builtin kill -USR2 $$ ; } & disown
#[ -z "${BASH_COMPLETION_COMPAT_DIR}" ] && [ -f /etc/bash_completion ] && . /etc/bash_completion

#   https://github.com/scop/bash-completion
## source files
#[ -r /usr/share/bash-completion/completions ] &&
#  . /usr/share/bash-completion/completions/*

# Check for interactive bash and that we haven't already been sourced.
if [ -n "${BASH_VERSION-}" -a -n "${PS1-}" -a -z "${BASH_COMPLETION_COMPAT_DIR-}" ]; then
    # Check for recent enough version of bash.
    if [ ${BASH_VERSINFO[0]} -gt 4 ] || [ ${BASH_VERSINFO[0]} -eq 4 -a ${BASH_VERSINFO[1]} -ge 1 ]; then
        [ -r "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion" ] && \
            . "${XDG_CONFIG_HOME:-$HOME/.config}/bash_completion"
        if shopt -q progcomp && [ -r /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi

fi

complete -W menuconfig make
complete -cf sudo

#[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && . $HOME/.autojump/etc/profile.d/autojump.sh


#FIXME
#certutil: function failed: SEC_ERROR_PKCS11_GENERAL_ERROR: A PKCS #11 module returned CKR_GENERAL_ERROR, indicating that an unrecoverable error has occurred.

##startup programs ----------------------------------------
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


#TODO if domainname=cnbj/seld
#[[ $(hostname) = "et.local" ]] || (\
[[ $(hostname) = cnbj* || $(hostname) = CNBJ* || $(hostname) = seld* ]] && \
  [[ $(ifconfig | egrep '10.147' | awk '{print $2} ') = 'addr:10.147'* ]] \
  && . ~/.myvar

#export ftp_proxy=http://proxy.global.net:8080
#export http_proxy=http://proxy.global.net:8080
#export https_proxy=http://proxy.global.net:8080
#export no_proxy=localhost,127.0.0.1,10.*,.corpusers.net

export IPOD_MOUNTPOINT=/media/

# export BBSHOME="/home/bbs"
# export WWWHOME="/home/bbs/www"
# export PHPHOME="/home/bbs/www/php"
# export SRCDIR="/home/"

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

#eval `keychain --eval --agents ssh id_rsa`
#eval `keychain --eval ~/.ssh/id_dsa`
#eval `keychain --eval ~/.ssh/id_rsa`

# curl https://mirrors.tuna.tsinghua.edu.cn/git/git-repo -o repo
export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo/'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# If running trom tty
if [ $(tty) == "/dev/tty3" ]; then
  sway
  exit 0
fi

### BlackArch Linux settings ###

# colors
darkgrey="$(tput bold ; tput setaf 0)"
white="$(tput bold ; tput setaf 7)"
red="$(tput bold; tput setaf 1)"
nc="$(tput sgr0)"

# exports
export PKG_CONFIG_PATH=/usr/X11R6/lib/pkgconfig:/usr/lib/pkgconfig
#export LD_LIBRARY_PATH=/lib:/usr/lib:/usr/share/lib:/usr/local/lib:/usr/local/share/lib:/usr/X11R6/lib:/opt/lib

export EDITOR=vim
# export INPUTRC=/etc/inputrc
export USER LOGNAME MAIL HOSTNAME
export VISUAL=$EDITOR
export CSCOPE_EDITOR="$EDITOR"
export WCDHOME="${HOME}/.wcd"
export BROWSER="x-www-browser"

# export RESIN_HOME
export SHLVL=1
export G_BROKEN_FILENAMES=1

export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:"
export PATH="${PATH}/opt/bin:/usr/bin/core_perl:/usr/games/bin:"
## [ "$UID" = "0" ] || export PATH=".:$PATH"
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

export PRINTER=tahiti-color
export PRINTER2=waikiki-color
export ENV=$HOME/.bashrc

export GOPATH=~/src/go
function KUBEGOPATH {
  export GOPATH=`pwd`/Godeps/_workspace:`pwd`/_output/local/go:$GOPATH
}

# if ! -z $CROSS_
# export CROSS_COMPILE=ppc_85xx-
# export TARGET_OS=linux


#fix java ugliness
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel"
#}2

export LD_PRELOAD=""

