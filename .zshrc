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
[[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && exec startx

## same, but doesn't exit if X fails
# [[ -z "$DISPLAY" && "$(fgconsole)" -eq 1 ]] && startx

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
# vi-mode in node repl
alias node='NODE_NO_READLINE=1 rlwrap node'

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

# serverless
[[ -f ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && \
  . ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
[[ -f ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && \
  . ~/.npm-global/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

# vim:filetype=zsh:foldmethod=marker:foldlevel=0
