# This is ~/.bash_profile; NOT ~/.profile
# .bash_profile is sourced by bash for login shells

# ~/.profile is *NOT* read by bash IF ~/.bash_profile or ~/.bash_login exists
# ~/.profile is executed by command interpreter (also /bin/sh ) for LOGIN shells


# always be found at /etc/skel/
# always be found at /etc/defaults/etc/skel/.profile

# The following line runs .bashrc recommended by the bash info pages.
#[[ -f ~/.bashrc ]] && . ~/.bashrc
[[ -f $HOME/.bashrc ]] && . $HOME/.bashrc

[[ -f ~/.extend.bash_profile ]] && . ~/.extend.bash_profile
