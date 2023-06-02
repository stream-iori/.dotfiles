DOTFILES=$HOME/.dotfiles
NVChadMaster=$HOME/codes/NvChad

echo -e "\nCopy NvChad Master"
echo "=============================="
cp -r $NVChadMaster $DOTFILES/config/nvim
rm -rf $DOTFILES/config/nvim/.git
rm -rf $DOTFILES/config/nvim/.github
rm -f $DOTFILES/config/nvim/.gitignore

echo -e "\n Copy NvChad Custom Config"
echo "=============================="
cp -r $DOTFILES/nvchad-custom $DOTFILES/config/nvim/lua/custom


