# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=45000
export GTK_OVERLAY_SCROLLING=0
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/n/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

source ~/.aliases
set -o vi
xrdb ~/.Xresources
source /bin/aws_zsh_completer.sh
setopt completealiases

# Turn on 256 color support
if [ "x$TERM" = "xxterm" ]
then
    export TERM="xterm-256color"
fi

autoload -Uz promptinit
autoload -U colors && colors

promptinit
prompt off


# Numeric Keypad
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey -s "^[5~" "Prior"
bindkey -s "^[6~" "Next"
bindkey -s "^[Oo" "/"
bindkey -s "^[Oj" "*"
bindkey -s "^[Om" "-"
bindkey -s "^[Ok" "+"

# Powerline
 powerline-daemon -q
 . /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

# SSH-Agent 
eval $(keychain --eval --quiet id_rsa)

