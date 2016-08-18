# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=45000
EDITOR=/usr/bin/nvim
BROWSER=/usr/bin/chromium
export GTK_OVERLAY_SCROLLING=0
setopt appendhistory
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
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

# End of lines added by compinstall
# SSH-Agent {{{
eval $(keychain --eval --quiet id_rsa)
# }}}

source ~/.aliases
set -o vi
xrdb ~/.Xresources
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

# Numeric Keypad {{{
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
 powerline-daemon -q
 . /usr/lib/python3.5/site-packages/powerline/bindings/zsh/powerline.zsh
# }}}

# OFF # Virtualenvwrapper {{{
# OFF export WORKON_HOME=$HOME/.virtualenvs
# OFF export PROJECT_HOME=/home/n/projects
# OFF source /usr/bin/virtualenvwrapper.sh
# OFF # }}}

# RVM {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
export PATH="$PATH:$HOME/.rvm/bin"
# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}}

# Turn off touchpad {{{
toff   # defined in ~/.aliases
# }}}

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
