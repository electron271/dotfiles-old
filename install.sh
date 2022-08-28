#!/bin/bash
############################
# install.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=$PWD                    # dotfiles directory
olddir=~/.dotfiles_old             # old dotfiles backup directory
# files="bashrc vimrc vim zshrc oh-my-zsh"    # list of files/folders to symlink in homedir

##########

# ask user if "dir" is correct
echo -n "Is $dir the correct dotfiles directory? (y/n) "
read answer
if [ "$answer" != "y" ]; then
    echo "Please run the script while in the correct dotfiles directory."
    exit 1
fi

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# zsh
echo "Installing zsh dotfiles"
ln -s $dir/zsh/zshrc ~/.zshrc
ln -s $dir/zsh/oh-my-zsh ~/.oh-my-zsh
echo "...done"

# xmonad
echo "Installing xmonad dotfiles"
ln -s $dir/xmonad ~/.xmonad
echo "...done"

# xmobar
echo "Installing xmobar dotfiles"
ln -s $dir/xmobar ~/.xmobar

# alacritty
echo "Installing alacritty dotfiles"
ln -s $dir/alacritty/alacritty.yml ~/.alacritty
echo "...done"

# echo final notes
echo "All done!"
echo "Final notes:
The neovim config was not copied as it is a preset config. (nvchad)
This program is BYOI (bring your own install), this will not install any packages, please check the dependencies section.
Dotfiles are made to fork, if you want, fork this repo and use this as a template!

created by electron271, made with love and caffeine"
