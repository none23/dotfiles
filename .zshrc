HISTFILE=~/.histfile
HISTSIZE=32000
SAVEHIST=128000
EDITOR=/usr/bin/nvim
BROWSER=/usr/bin/chromium
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
export QT_QPA_PLATFORMTHEME='gtk2'
setopt appendhistory
bindkey -v
set -o vi

# SSH-Agent {{{
eval $(keychain --eval --quiet id_rsa)
# }}}
# automatic startx {{{
# [ [ -z "$DISPLAY" ] && [ "$(fgconsole)" -eq 1 ] ] && exec startx
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
# Powerline {{{
autoload -U colors && colors
# autoload -Uz promptinit
# promptinit
prompt off
 powerline-daemon -q
 . /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh

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
# Virtualenvwrapper {{{

# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=/home/n/projects
# source /usr/bin/virtualenvwrapper.sh

# }}}
# RVM {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# }}}
# npm {{{
[[ -d ~/.npm-global ]] && [[ -d ~/.npm-global/bin ]] || mkdir -p ~/.npm-global/bin
export PATH="$HOME/.npm-global/bin:$PATH"
# }}}

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
