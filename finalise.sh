#!/bin/bash

set -ex

chsh -s /usr/bin/zsh

nvim --headless +PlugInstall +qa

zsh -ci 'zplug check && zplug install'
