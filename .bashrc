# .bashrc



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

## xbps

alias i='doas xbps-install -S'
alias u='i ; doas xbps-install -u xbps; doas xbps-install -u'
alias q='doas xbps-query -Rs'
alias r='doas xbps-remove -R'

## vim
alias vi='vim'

## command alias
alias cls='clear'
alias ll='ls -la'

## terminal vim-like
set -o vi




