# ~/.bash_logout: executed by bash(1) when login shell exits.

# clear sensitive history
/bin/rm $HOME/.mysql_history

# when leaving the console clear the screen to increase privacy
clear

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

# XXX
printf "\033c"

