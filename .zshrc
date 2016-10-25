HISTFILE=~/.histfile
HISTSIZE=16000
SAVEHIST=64000
EDITOR=/usr/bin/nvim
BROWSER=/usr/bin/chromium
export GTK_OVERLAY_SCROLLING=0
export QT_QPA_PLATFORMTHEME="qt5ct"
setopt appendhistory
bindkey -v
set -o vi
xrdb ~/.Xresources

# numeric keypad {{{
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line
bindkey -s "^[5~" "Prior"
bindkey -s "^[6~" "Next"
bindkey -s "^[Oo" "/"
bindkey -s "^[Oj" "*"
bindkey -s "^[Om" "-"
bindkey -s "^[Ok" "+"
# }}}
# completion zstyle  {{{
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

# }}}
# Powerline {{{
autoload -U colors && colors
# autoload -Uz promptinit
# promptinit
prompt off
 powerline-daemon -q
 . /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

# }}}
# SSH-Agent {{{
eval $(keychain --eval --quiet id_rsa)
# }}}
# Virtualenvwrapper {{{
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=/home/n/projects
source /usr/bin/virtualenvwrapper.sh

# }}}
# RVM {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# }}}
# aliases {{{
source ~/.aliases

if [[ -a ~/.private_aliases ]]; then
    source ~/.private_aliases
fi
# }}}
# zshrc-local {{{
if [[ -a ~/.zshrc_local ]]; then
    source ~/.zshrc_local
fi
# }}}
# syntax-highlighting {{{
if [[ -a  ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
    source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
# }}}
# automatic startx {{{
if [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ]; then
    exec startx
fi
# }}}

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
