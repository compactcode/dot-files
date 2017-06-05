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

# fj - cd to selected mru directory
#
# fj                => select => cd
# fj search_pattern => cd
fj() {
  local search_pattern selected_directory

  search_pattern=$1

  if [[ -n $search_pattern ]]
  then
    selected_directory=$(fasd -dlR $search_pattern | head -1)
  else
    selected_directory=$(fasd -dlR | fzf)
  fi

  if [[ -n $selected_directory ]]
  then
    cd $selected_directory
  fi
}


# Go to a frequently used directory.
alias j="fj"
# Go straight to your most used directory.
alias jj="fasd -dlR | head -1"
