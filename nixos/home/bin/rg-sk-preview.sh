#!/bin/sh

# Adapted from https://github.com/junegunn/fzf.vim/blob/master/bin/preview.sh

# Takes single line results from rg and outputs enough text to display in a skim preview window.
#
# e.g: rg --column --no-heading bundler
#
# => config/boot.rb:3:10:require 'bundler/setup' # Set up gems listed in the Gemfile.

REVERSE="\x1b[7m"
RESET="\x1b[m"

if [ "$1" == "-v" ]; then
  SPLIT=1
  shift
fi

if [ -z "$1" ]; then
  echo "usage: $0 [-v] FILENAME[:LINENO][:IGNORED]"
  exit 1
fi

IFS=':' read -r -a INPUT <<< "$1"
FILE=${INPUT[0]}
CENTER=${INPUT[1]}

if [ ! -r "$FILE" ]; then
  echo "File not found ${FILE}"
  exit 1
fi

if [[ "$(file --mime "$FILE")" =~ binary ]]; then
  echo "$1 is a binary file"
  exit 0
fi

if [ -z "$CENTER" ]; then
  CENTER=1
fi

if [ -n "$SKIM_PREVIEW_HEIGHT" ]; then
  LINES=$SKIM_PREVIEW_HEIGHT
else
  if [ -r /dev/tty ]; then
    LINES=$(stty size < /dev/tty | awk '{print $1}')
  else
    LINES=40
  fi
  if [ -n "$SPLIT" ]; then
    LINES=$(($LINES/2)) # using horizontal split
  fi
  LINES=$(($LINES-2)) # remove preview border
fi

FIRST=$(($CENTER-$LINES/3))
FIRST=$(($FIRST < 1 ? 1 : $FIRST))
LAST=$((${FIRST}+${LINES}-1))

bat --color always --theme base16 -r $FIRST:$LAST $FILE
