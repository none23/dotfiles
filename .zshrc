#!/bin/zsh

export EDITOR=nvim
export VISUAL=nvim
export BROWSER=chromium
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bindkey -v
set -o vi

# history
HISTFILE=~/.histfile
HISTSIZE=32000
SAVEHIST=128000
setopt appendhistory

# ssh-agent
eval $(keychain --eval --quiet id_rsa)

# automatic startx on tty1
[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && exec startx

## same, but doesn't exit if X fails
# [[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && startx

# zstyle completions {{{
zstyle :compinstall filename '/home/n/.zshrc'
zstyle ':acceptline' rehash true
zstyle ':completion:*:*:*:users' ignored-patterns \
    adm apache bin daemon games gdm halt ident junkbust lp mail mailnull \
    named news nfsnobody nobody nscd ntp operator pcap postgres radvd \
    rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs backup  bind  \
    dictd  gnats  identd  irc  man  messagebus  postfix  proxy  sys  www-data
zstyle nocompwarn true
autoload -Uz compinit
compinit
setopt completealiases

# numeric keypad
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey -s "^[5~" "Prior"
bindkey -s "^[6~" "Next"
bindkey -s "^[Oo" "/"
bindkey -s "^[Oj" "*"
bindkey -s "^[Om" "-"
bindkey -s "^[Ok" "+"

# powerline
autoload -U colors && colors
prompt off
powerline-daemon -q
. /usr/lib/python3.6/site-packages/powerline/bindings/zsh/powerline.zsh

# }}}
# profile
source ~/.profile || echo '~/.profile not found'

# syntax-highlighting
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2> /dev/null || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.zsh-syntax-highlighting || \
  echo 'failed to install zsh-syntax-highlighting'

# virtualenvwrapper
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=/home/n/projects
# source /usr/bin/virtualenvwrapper.sh

# fzf
if [[ -n ~/.fzf/shell ]]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

source ~/.fzf/shell/completion.zsh 2> /dev/null
source ~/.fzf/shell/key-bindings.zsh

# zshrc-local
[[ -a ~/.zshrc-local ]] && source ~/.zshrc-local || touch

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
