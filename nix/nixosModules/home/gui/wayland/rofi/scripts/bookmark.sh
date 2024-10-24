#!/usr/bin/env bash

# adapted from https://raw.githubusercontent.com/knatsakis/rofi-buku/master/rofi-buku

_rofi() {
  rofi -dmenu -i -no-levenshtein-sort -width 1000 "$@"
}

# display settings
display_type=3
max_str_width=80

main() {
  bookmarks=$(parseBuku)

  selected=$(echo "${bookmarks}" | _rofi -p '> ' -filter "${filter}")

  if [[ $? -eq 1 ]]; then
    exit
  else
    id=$(getId "$bookmarks" "$selected")
    hyprctl dispatch focuswindow class:firefox
    for bm in ${id}; do
      hyprctl dispatch exec firefox "$(buku -p "$bm" -f 1 | awk '{print $2}')"
    done
  fi
}

parseBuku() {
  buku --nostdin --nc -p | grep -v '^waiting for input$' | gawk -v max="$max_str_width" -v type="$display_type" '
    BEGIN { RS=""; FS="\n" }
    {
      id = gensub(/([0-9]+)\.(.*)/, "\\1", "g", $1)

      title = substr(gensub(/[0-9]+\.\s*(.*)/, "\\1", "g", $1),0,max)
      url = substr(gensub(/\s+> (.*)/, "\\1", "g", $2),0,max)

      if ($3 ~ /^\s+\+ /)
        comment = gensub(/\s+\+ (.*)/, "\\1", "g", $3)
      else
        comment = ""

      if ($3 ~ /^\s+# /)
        tags = gensub(/\s+# (.*)/, "\\1", "g", $3)
      else
        if ($4 ~ /^\s+# /)
          tags = gensub(/\s+# (.*)/, "\\1", "g", $4)
        else
          tags = "NOTAG"

      print id " \t" title "\t" url "\t" tags
    }
  ' | column -t -s $'\t'
}

getId() {
  id="${2%% *}"
  if [ -z "$id" ]; then
    prev=""
    IFS=$'\n'
    for line in $1; do
      if [ "$2" = "$line" ]; then
        id="${prev%% *}"
        break
      else
        prev="$line"
      fi
    done
  fi
  echo "$id"
}

main
