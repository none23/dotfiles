#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

source ~/.profile

source ~/.fzf/shell/completion.bash 2> /dev/null
source ~/.fzf/shell/key-bindings.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
