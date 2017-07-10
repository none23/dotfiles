export EDITOR=nvim
export VISUAL=nvim
export BROWSER=chromium
export QT_QPA_PLATFORMTHEME="qt5ct"
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
bindkey -v
set -o vi
# history {{{
HISTFILE=~/.histfile
HISTSIZE=32000
SAVEHIST=128000
setopt appendhistory
# }}}
# SSH-Agent {{{
eval $(keychain --eval --quiet id_rsa)
# }}}
# automatic startx {{{
[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && exec startx
## same, but doesn't exit if X fails
# [[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && startx
# }}}
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
# }}}
# powerline {{{
autoload -U colors && colors
prompt off
powerline-daemon -q
. /usr/lib/python3/dist-packages/powerline/bindings/zsh/powerline.zsh

# }}}
# profile {{{
source ~/.profile || echo '~/.profile not found'
# }}}
# syntax-highlighting {{{
source ~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh || echo '~/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh not found'
# }}}
# [OFF] virtualenvwrapper {{{
# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=/home/n/projects
# source /usr/bin/virtualenvwrapper.sh
# }}}
# zshrc-local {{{
[[ -a ~/.zshrc-local ]] && source ~/.zshrc-local
# }}}

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
