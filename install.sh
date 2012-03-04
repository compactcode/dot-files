#!/bin/bash

git submodule update --init

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

ln -vsf "$MY_PATH/files/.ackrc" ~
ln -vsf "$MY_PATH/files/.aliases" ~
ln -vsf "$MY_PATH/files/.bash_profile" ~
ln -vsf "$MY_PATH/files/.bashrc" ~
ln -vsf "$MY_PATH/files/.gemrc" ~
ln -vsf "$MY_PATH/files/.gitconfig" ~
ln -vsf "$MY_PATH/files/.gitignore" ~
ln -vsf "$MY_PATH/files/.hushlogin" ~
ln -vsf "$MY_PATH/files/.inputrc" ~
ln -vsf "$MY_PATH/files/.oh-my-zsh" ~
ln -vsf "$MY_PATH/files/.rbenv" ~
ln -vsf "$MY_PATH/files/.rspec" ~
ln -vsf "$MY_PATH/files/.vim" ~
ln -vsf "$MY_PATH/files/.vimrc" ~
ln -vsf "$MY_PATH/files/.zshrc" ~
