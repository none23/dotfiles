# RVM {{{
export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin"
export PATH="$PATH:$HOME/.rvm/bin"
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# }}}
# npm {{{
[[ -d ~/.npm-global ]] && [[ -d ~/.npm-global/bin ]] || mkdir -p ~/.npm-global/bin
export PATH="$HOME/.npm-global/bin:$PATH"
# }}}
