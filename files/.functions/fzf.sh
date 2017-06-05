# fkill - kill process
fkill() {
  local pid

  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fd - cd to selected sub directory
fd() {
  local selected_directory
  selected_directory=$(find . -type d | grep -v '\.git' | fzf)

  if [[ -n $selected_directory ]]
  then
    cd $selected_directory
  fi
}

# fco - checkout a git branch
fco() {
  local selected_branch

  selected_branch=$(git branch --all | fzf)

  if [[ -n $selected_branch ]]
  then
    git checkout $(echo "$selected_branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
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
