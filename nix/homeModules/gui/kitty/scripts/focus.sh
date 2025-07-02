#!/usr/bin/env bash
set -euo pipefail

TAB_TITLE=$1
shift

# check if a tab with the given title already exists
if kitty @ ls | jq -e --arg title "$TAB_TITLE" '.[] | .tabs[] | select(.title == $title)' >/dev/null; then
  kitty @ focus-tab --match "title:$TAB_TITLE"
else
  if [ $# -gt 0 ]; then
    # create tab with given command
    kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current "$@"
  else
    # create defaut tab
    kitty @ launch --type=tab --tab-title "$TAB_TITLE" --cwd=current
  fi
fi
