#!/bin/sh

address=$(hyprctl clients -j | jq -r "map(select(.workspace.id == $1 and .class == \"$2\")) | .[0].address")

if [[ $address == "null" ]]; then
  hyprctl dispatch exec [workspace "$1"] "$3"
else
  hyprctl dispatch focuswindow address:"$address"
fi
