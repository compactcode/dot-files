#!/usr/bin/env bash

_rofi() {
  rofi -dmenu -i -no-levenshtein-sort -width 1000 "$@"
}

main() {
  projects=$(zoxide query -l | rg "$XDG_PROJECTS_DIR")

  selected=$(echo "${projects}" | _rofi -p '> ' -filter "${filter}")

  if [[ $? -eq 1 ]]; then
    exit
  elif [[ -n $selected ]]; then
    hyprctl dispatch exec -- kitty -d "$selected" zellij -l project
  fi
}

main
