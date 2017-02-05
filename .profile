# aliases {{{
source ~/.aliases

if [[ -a ~/.private_aliases ]]; then
    source ~/.private_aliases
fi
# }}}
# rvm {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}}
# npm {{{
[[ -d ~/.npm-global ]] && [[ -d ~/.npm-global/bin ]] || mkdir -p ~/.npm-global/bin
export PATH="$HOME/.npm-global/bin:$PATH"
# }}}
# vim:filetype=zsh:foldmethod=marker:foldlevel=0
