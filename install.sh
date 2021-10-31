name=`id -un`
#brew install antigen

ln -s /Users/${name}/.dotfiles/.zshrc /Users/${name}/.zshrc
ln -s /Users/${name}/.dotfiles/.zshenv /Users/${name}/.zshenv
ln -s /Users/${name}/.dotfiles/oh-my-zsh/custom /Users/${name}/.oh-my-zsh/custom

ln -s /Users/${name}/.dotfiles/.ideavimrc /Users/${name}/.ideavimrc

#have to install plugins
ln -s /Users/${name}/.dotfiles/.tmux.conf /Users/${name}/.tmux.conf

ln -s /Users/${name}/.dotfiles/.tmux /Users/${name}/.tmux

#have to install plugins
#ln -s init.vim  /Users/${name}/.config/nvim/init.vim

#ln -s /Users/${name}/codes/dotFiles/cheat /Users/${name}/.config/cheat
