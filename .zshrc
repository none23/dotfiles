#!/bin/zsh

export LANG=en_US.UTF-8

export EDITOR=nvim
export VISUAL="konsole -e nvim"

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

bindkey -v
set -o vi

# history
HISTFILE=~/.histfile
HISTSIZE=128000
SAVEHIST=1024000
setopt appendhistory

# ssh-agent
eval $(keychain --eval --quiet id_rsa)

# automatic startx on tty1
[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && exec startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1


## same, but doesn't exit if X fails
#[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && startx "$XDG_CONFIG_HOME/X11/xinitrc" -- "$XDG_CONFIG_HOME/X11/xserverrc" vt1

# zstyle completions {{{
zstyle :compinstall filename '/home/n/.zshrc'
zstyle ":completion:*:commands" rehash 1 # do not trust completions cache
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
. /usr/lib/python3.8/site-packages/powerline/bindings/zsh/powerline.zsh

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
# Use fd instead of the default find command for listing path candidates.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
function install_fzf {
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
}
source ~/.fzf/shell/completion.zsh 2> /dev/null || install_fzf
source ~/.fzf/shell/key-bindings.zsh

export FZF_DEFAULT_COMMAND='(git ls-tree -r --name-only HEAD || fd --type f --exclude coverage --exclude node_modules --exclude flow-typed) 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# zshrc-local
[[ -a ~/.zshrc-pre ]] && source ~/.zshrc-pre || touch ~/.zshrc-pre
[[ -a ~/.zshrc-post ]] && source ~/.zshrc-post || touch ~/.zshrc-post

# xdg settings
[[ -n "XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME="$HOME/.config"
[[ -n "XDG_DATA_HOME" ]] || export XDG_DATA_HOME="$HOME/.local/share"
[[ -n "XDG_RUNTIME_DIR" ]] || export XDG_RUNTIME_DIR="/run/user/$(id -u)"
[[ -n "XDG_CACHE_HOME" ]] || export  XDG_CACHE_HOME="$HOME/.cache"

export ATOM_HOME="$XDG_DATA_HOME"/atom
export ACKRC="$XDG_CONFIG_HOME/ack/ackrc"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GTK_RC_FILES="$XDG_CONFIG_HOME"/gtk-1.0/gtkrc
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export KDEHOME="$XDG_CONFIG_HOME"/kde
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PSQL_HISTORY="$XDG_CACHE_HOME/pg/psql_history"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
export SCREENRC="$XDG_CONFIG_HOME"/screen/screenrc
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wgetrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export ANDROID_SDK_HOME="$XDG_CONFIG_HOME"/android

echo hsts-file \= "$XDG_CACHE_HOME"/wget-hsts >> "$XDG_CONFIG_HOME/wgetrc"

[[ -d "$XDG_CONFIG_HOME/pg" ]] || mkdir "$XDG_CACHE_HOME/pg"
[[ -d "$XDG_CACHE_HOME/pg" ]] || mkdir "$XDG_CACHE_HOME/pg"

alias mitmproxy="mitmproxy --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias mitmweb="mitmweb --set confdir=$XDG_CONFIG_HOME/mitmproxy"
alias tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
alias wget="wget --hsts-file=$XDG_CACHE_HOME/wget-hsts"

# serverless
[[ -f ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && \
  . ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
[[ -f ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && \
  . ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# vim:filetype=zsh:foldmethod=marker:foldlevel=0

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
