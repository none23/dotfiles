# aliases
source $HOME/.aliases
source $HOME/.private-aliases || touch $HOME/.private-aliases || echo "failed to create ~/.private-aliases"

# rvm
if [[ -a ~/.gem/ruby/2.4.0/bin ]]; then
    export PATH="$PATH:$HOME/.gem/ruby/2.4.0/bin:$HOME/.rvm/bin"
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
fi

# npm/yarn
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.yarn-global/bin:$PATH"
[[ -a "$HOME/.npm-global/bin" ]] || mkdir -p "$HOME/.npm-global/bin"
[[ -a "$HOME/.yarn/bin" ]] || mkdir -p "$HOME/.yarn-global/bin"

# vim:filetype=zsh
