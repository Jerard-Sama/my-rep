# .bash_profile

##general
export BROWSER="firefox"
export TERMINAL="st"
export TERM="st"

##loadkeys
doas loadkeys .config/loadkeys/loadkeysrc

# Get the aliases and functions
[ -f $HOME/.bashrc ] && . $HOME/.bashrc

## dwm
[[! $DISPLAY && $(tty) = "/dev/tty1" ]] && startx
startx
