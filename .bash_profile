# This is ~/.bash_profile; NOT ~/.profile
# ~/.bash_profile is sourced by BASH for login shells
# ~/.profile is *NOT* read by BASH IF ~/.bash_profile or ~/.bash_login exists
# ~/.profile should be executed by command interpreter (also /bin/sh ) for LOGIN shells

# Deal with settings in .bashrc, and source it in ~/.bash_profile

[ -r ~/.bashrc ] && source ~/.bashrc
