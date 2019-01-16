# ~/.profile: executed by Bourne-compatible login shells.

# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.

#~/.profile is *NOT* read by bash IF ~/.bash_profile or ~/.bash_login exists
#~/.profile is executed by command interpreter (also /bin/sh ) for LOGIN shells

# NOTE that other shells will also read it.

# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# dpkg -s base-files | grep Description: -A50
# Description: Debian base system miscellaneous files
# This package contains the basic filesystem hierarchy of a Debian system, and
# several important miscellaneous files, such as /etc/debian_version,
# /etc/host.conf, /etc/issue, /etc/motd, /etc/profile, and others,
# and the text of several common licenses in use on Debian systems.
# dpkg -L base-files | grep profile$
# /usr/share/base-files/dot.profile
# /usr/share/base-files/profile

##### COPY from /usr/share/base-files/profile, starts
# /etc/profile: system-wide .profile file for the Bourne shell (sh(1))
# and Bourne compatible shells (bash(1), ksh(1), ash(1), ...).

if [ "${PS1-}" ]; then
  if [ "${BASH-}" ] && [ "$BASH" != "/bin/sh" ]; then
    # The file bash.bashrc already sets the default PS1.
    # PS1='\h:\w\$ '
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

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
  unset i
fi
##### COPY from /usr/share/base-files/profile, ends

##### COPY from /usr/share/base-files/dot.profile, starts
# ~/.profile: executed by Bourne-compatible login shells.

if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

mesg n || true
##### COPY from /usr/share/base-files/dot.profile, ends


#[[ -s $HOME/.autojump/etc/profile.d/autojump.sh ]] && . $HOME/.autojump/etc/profile.d/autojump.sh
# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

mesg n


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

#set -o vi
set -o emacs

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/shims:$PATH"

TZ='Asia/Shanghai'; export TZ

## [ "$UID" = "0" ] || export PATH=".:$PATH"

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

# colors
darkgrey="$(tput bold ; tput setaf 0)"
white="$(tput bold ; tput setaf 7)"
red="$(tput bold; tput setaf 1)"
nc="$(tput sgr0)"

alias ls="ls --color"
alias shred="shred -zf"
alias python="python2"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"

export PS1="\[$darkgrey\][ \[$red\]\u@\h:\w \[$white\]\W\[$red\] \[$darkgrey\]]\\[$red\]# \[$nc\]"
#export PS1="\[$darkgrey\][ \[$red\]\u@\h \[$white\]\W\[$red\] \[$darkgrey\]]\\[$red\]# \[$nc\] \w$ "
export LD_PRELOAD=""

alias ls="ls --color"
#alias vi="vim"
alias shred="shred -zf"
alias python="python2"
alias wget="wget -U 'noleak'"
alias curl="curl --user-agent 'noleak'"

export VISUAL=vim
export EDITOR=vim

# export INPUTRC=/etc/inputrc
export USER LOGNAME MAIL HOSTNAME 

# Append our default paths
appendpath () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="$PATH:$1"
    esac
}

export PATH="/bin:/sbin:/usr/bin:/usr/sbin"
appendpath '/usr/local/sbin'
appendpath '/usr/local/bin'
appendpath '/opt/bin'
appendpath '/usr/games/bin'
appendpath '/usr/games'

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
unset appendpath

export PATH
