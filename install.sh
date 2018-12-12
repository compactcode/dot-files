#!/bin/bash

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

mkdir -p ~/.config

ln -vsf "$MY_PATH/files/.alacritty.yml" ~
ln -vsf "$MY_PATH/files/.bash_aliases" ~
ln -vsf "$MY_PATH/files/.bash_profile" ~
ln -vsf "$MY_PATH/files/.bashrc" ~
ln -vsf "$MY_PATH/files/.gemrc" ~
ln -vsf "$MY_PATH/files/.gitconfig" ~
ln -vsf "$MY_PATH/files/.gitignore" ~
ln -vsf "$MY_PATH/files/.inputrc" ~
ln -vsf "$MY_PATH/files/.rspec" ~
ln -vsf "$MY_PATH/files/.vim" ~
ln -vsf "$MY_PATH/files/.vim/config/nvim" ~/.config
ln -vsf "$MY_PATH/files/.zsh_functions" ~
ln -vsf "$MY_PATH/files/.zshrc" ~
