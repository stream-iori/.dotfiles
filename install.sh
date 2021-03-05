name=`id -un`

ln -s /Users/${name}/codes/dotFiles/.zshrc /Users/${name}/.zshrc
ln -s /Users/${name}/codes/dotFiles/.zshenv /Users/${name}/.zshenv
curl https://raw.githubusercontent.com/cheat/cheat/master/scripts/cheat.zsh -o ~/.cheat.zsh

ln -s /Users/${name}/codes/dotFiles/.ideavimrc /Users/${name}/.ideavimrc

#have to install plugins
ln -s /Users/${name}/codes/dotFiles/.tmux.conf /Users/${name}/.tmux.conf

ln -s /Users/${name}/codes/dotFiles/.tmux /Users/${name}/.tmux

#have to install plugins
ln -s init.vim  /Users/${name}/.config/nvim/init.vim

ln -s /Users/${name}/codes/dotFiles/cheat /Users/${name}/.config/cheat
