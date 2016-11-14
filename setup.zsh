#!/bin/zsh

DOTFILES_PATH=$(pwd)

# vim {{{

[[ -a ~/.config/nvim ]] && mv ~/.config/nvim{,.old}
ln -s $DOTFILES_PATH/.vim ~/.config/nvim
ln -s $DOTFILES_PATH/.vimrc ~/.config/nvim/init.vim

[[ -a ~/.vim ]] && mv ~/.vim{,.old}
ln -s $DOTFILES_PATH/.vim ~/.vim

[[ -a ~/.vimrc ]] && mv ~/.vimrc{,.old}
ln -s $DOTFILES_PATH/.vimrc ~/.vimrc

# /vim }}}
# zsh {{{

[[ -a ~/.zshrc ]] && mv ~/.zshrc{,.old}
ln -s $DOTFILES_PATH/.zshrc ~/.zshrc

[[ -a ~/.aliases ]] && mv ~/.aliases{,.old}
ln -s $DOTFILES_PATH/.aliases ~/.aliases

[[ -a ~/.zcompdump ]] && mv ~/.zcompdump{,.old}
ln -s $DOTFILES_PATH/.zcompdump ~/.zcompdump

[[ -a ~/.zdirs ]] && mv ~/.zdirs{,.old}
ln -s $DOTFILES_PATH/.zdirs ~/.zdirs

[[ -a ~/.zprofile ]] && mv ~/.zprofile{,.old}
ln -s $DOTFILES_PATH/.zprofile ~/.zprofile

[[ -a ~/.zsh-syntax-highlighting ]] && mv ~/.zsh-syntax-highlighting{,.old}
ln -s $DOTFILES_PATH/.zsh-syntax-highlighting ~/.zsh-syntax-highlighting

# /zsh }}}
# bash {{{

[[ -a ~/.bashrc ]] && mv ~/.bashrc{,.old}
ln -s $DOTFILES_PATH/.bashrc ~/.bashrc

[[ -a ~/.bash_profile ]] && mv ~/.bash_profile{,.old}
ln -s $DOTFILES_PATH/.bash_profile ~/.bash_profile

# /bash }}}
# misc {{{

[[ -a ~/.config/awesome ]] && mv ~/.config/awesome{,.old}
ln -s $DOTFILES_PATH/.config/awesome ~/.config/awesome

[[ -a ~/.dmrc ]] && mv ~/.dmrc{,.old}
ln -s $DOTFILES_PATH/.dmrc ~/.dmrc

[[ -a ~/.xinitrc ]] && mv ~/.xinitrc{,.old}
ln -s $DOTFILES_PATH/.xinitrc ~/.xinitrc

[[ -a ~/.Xmodmap ]] && mv ~/.Xmodmap{,.old}
ln -s $DOTFILES_PATH/.Xmodmap ~/.Xmodmap

[[ -a ~/.Xresources ]] && mv ~/.Xresources{,.old}
ln -s $DOTFILES_PATH/.Xresources ~/.Xresources

[[ -a ~/.xscreensaver ]] && mv ~/.xscreensaver{,.old}
ln -s $DOTFILES_PATH/.xscreensaver ~/.xscreensaver

[[ -a ~/.cvimrc ]] && mv ~/.cvimrc{,.old}
ln -s $DOTFILES_PATH/.cvimrc ~/.cvimrc

[[ -a ~/.fonts ]] && mv ~/.fonts{,.old}
ln -s $DOTFILES_PATH/.fonts ~/.fonts

[[ -a ~/.gnome2 ]] && mv ~/.gnome2{,.old}
ln -s $DOTFILES_PATH/.gnome2 ~/.gnome2

[[ -a ~/.gtkrc-2.0 ]] && mv ~/.gtkrc-2.0{,.old}
ln -s $DOTFILES_PATH/.gtkrc-2.0 ~/.gtkrc-2.0

[[ -a ~/.icons ]] && mv ~/.icons{,.old}
ln -s $DOTFILES_PATH/.icons ~/.icons

[[ -a ~/.inputrc ]] && mv ~/.inputrc{,.old}
ln -s $DOTFILES_PATH/.inputrc ~/.inputrc

[[ -a ~/.vimperator ]] && mv ~/.vimperator{,.old}
ln -s $DOTFILES_PATH/.vimperator ~/.vimperator

[[ -a ~/.vimperatorrc ]] && mv ~/.vimperatorrc{,.old}
ln -s $DOTFILES_PATH/.vimperatorrc ~/.vimperatorrc

[[ -a ~/.i3 ]] && mv ~/.i3{,.old}
ln -s $DOTFILES_PATH/.i3 ~/.i3

[[ -a ~/.ipython ]] && mv ~/.ipython{,.old}
ln -s $DOTFILES_PATH/.ipython ~/.ipython

[[ -a ~/.tmux.conf ]] && mv ~/.tmux.conf{,.old}
ln -s $DOTFILES_PATH/.tmux.conf ~/.tmux.conf

[[ -a ~/.i3 ]] && mv ~/.i3{,.old}
ln -s $DOTFILES_PATH/.i3 ~/.i3

# /misc }}}
