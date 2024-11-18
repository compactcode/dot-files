#!/bin/sh

address=$(hyprctl clients -j | jq -r "map(select(.workspace.id == $1 and .class == \"kitty\")) | .[0].address")

if [[ $address == "null" ]]; then
  hyprctl dispatch workspace "$1"
  hyprctl dispatch exec ~/.local/share/rofi/project.sh
else
  hyprctl dispatch focuswindow address:"$address"
fi
