#!/bin/bash
#bash nvchad.sh master  # 执行 copy_nvchad_master 函数
#bash nvchad.sh custom  # 执行 copy_nvchad_custom 函数

DOTFILES=$HOME/.dotfiles
NVChadMaster=$HOME/codes/NvChad

copy_nvchad_master() {
    rm -rf $DOTFILES/config/nvim

    echo -e "\nCopy NvChad Master"
    echo "=============================="
    cp -r $NVChadMaster $DOTFILES/config/nvim
    rm -rf $DOTFILES/config/nvim/.git
    rm -rf $DOTFILES/config/nvim/.github
    rm -f $DOTFILES/config/nvim/.gitignore
}

copy_nvchad_custom() {
    rm -rf $DOTFILES/config/nvim/lua/custom

    echo -e "\nCopy NvChad Custom Config"
    echo "=============================="
    cp -r $DOTFILES/nvchad-custom $DOTFILES/config/nvim/lua/custom
}

if [ "$1" = "master" ]; then
    copy_nvchad_master
elif [ "$1" = "custom" ]; then
    copy_nvchad_custom
else
    echo "Invalid argument. Usage: $0 [master|custom]"
    exit 1
fi

