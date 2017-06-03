# fd - cd to selected directory
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -type d -print | grep -v '\.git' 2> /dev/null | fzf +m) && cd "$dir"
}

# fco - checkout a git branch
fco() {
  local branches branch
  branches=$(git branch --all) &&
  branch=$(echo "$branches" |
           fzf -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# frg - search files and select a result
frg() {
  # TODO: Require param.
  # TODO: Handle no results.
  # TODO: Cleanup the selected result.
  rg --column --no-heading --hidden -i --color always $@ | grep -v '\.git' | fzf --ansi --preview '~/.functions/preview-search-result.sh {}'
}
