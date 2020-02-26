#!/bin/bash

set -ex

MY_PATH=`dirname "$0"`
MY_PATH=`( cd "$MY_PATH" && pwd )`

mkdir -p ~/.config
mkdir -p ~/.local/share

ln -vsf  "$MY_PATH/files/.bashrc"                "$HOME"
ln -vsf  "$MY_PATH/files/.zshrc"                 "$HOME"
ln -vsfn "$MY_PATH/files/.config/git"            "$HOME/.config/git"
ln -vsfn "$MY_PATH/files/.config/nvim"           "$HOME/.config/nvim"
ln -vsfn "$MY_PATH/files/.local/share/nvim/site" "$HOME/.local/share/nvim/site"
ln -vsfn "$MY_PATH/files/.local/share/sh"        "$HOME/.local/share/sh"
