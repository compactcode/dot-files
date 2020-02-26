#!/bin/bash

sh ./apt.sh
sh ./homebrew.sh
sh ./link.sh

zsh -c 'zplug install'
