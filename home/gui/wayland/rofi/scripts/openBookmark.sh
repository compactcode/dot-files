#!/usr/bin/env bash

# adapted from https://raw.githubusercontent.com/knatsakis/rofi-buku/master/rofi-buku

_rofi () {
    rofi -dmenu -i -no-levenshtein-sort -width 1000 "$@"
}

# display settings
display_type=3
max_str_width=80

# keybindings
switch_view="Alt+Tab"

main () {
    if [[ $mode == "bookmarks" ]]; then
        content=$(parseBuku)
        menu=$(echo "${content}" | _rofi -p '> ' -filter "${filter}" -kb-custom-2 "${switch_view}")
    elif [[ $mode == "tags" ]]; then
      menu=$(buku --nostdin --np --st | grep -v -e '^waiting for input$' -e '^$' | awk '{$NF=""; print $0}' | cut -d ' ' -f2  | _rofi -p '> ' -kb-custom-2 "${switch_view}")
    fi
    val=$?
    if [[ $val -eq 1 ]]; then
        exit
    elif [[ $val -eq 11 ]]; then
        if [[ $mode == "bookmarks" ]]; then
            export mode="tags"
            mode=tags main
        elif [[ $mode == "tags" ]]; then
            export mode="bookmarks"
            mode=bookmarks main
        fi
    elif [[ $val -eq 0 ]]; then
        if [[ $mode == "bookmarks" ]]; then
            id=$(getId "$content" "$menu")
            for bm in ${id}; do
                buku --nostdin -o "${bm}"
            done
        elif [[ $mode == "tags" ]]; then
            filter="${menu}" mode="bookmarks" main
        fi
    fi
}

parseBuku () {
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

      if (type == 1)
        print id "\t" url "\t" tags
      if (type == 2)
        print id "\t" title "\t" tags
      if (type == 3)
        print id " \t" title "\t" url "\t" tags

      print ""
    }
  ' | column -t -s $'\t'
}

getId () {
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
  echo $id
}

mode=bookmarks main
