# aliases {{{
source $HOME/.aliases
source $HOME/.private_aliases || echo "$HOME/.private_aliases not found"
# }}}
# rvm {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}}
# npm {{{
export PATH="$HOME/.npm-global/bin:$PATH" || echo "adding $HOME/.npm-global/bin to PATH failed somehow..."
# }}}
# vim:filetype=zsh:foldmethod=marker:foldlevel=0
