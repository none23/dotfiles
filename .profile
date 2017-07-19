# aliases {{{
source $HOME/.aliases
source $HOME/.private-aliases || echo "$HOME/.private-aliases not found"

# }}}
# rvm {{{
if [[ -a ~/.gem/ruby/2.3.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.3.0/bin:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# }}}
# npm {{{
[[ -a ~/.npm-global/bin ]] || mkdir -p ~/.npm-global/bin
export PATH="$HOME/.npm-global/bin:$PATH" || echo "adding $HOME/.npm-global/bin to PATH failed somehow..."

# }}}
# yarn {{{
[[ -a ~/.yarn/bin ]] || mkdir -p ~/.yarn/bin
export PATH="$HOME/.yarn/bin:$PATH" || echo "adding $HOME/.yarn/bin to PATH failed somehow..."

# }}}
# vim:filetype=zsh
