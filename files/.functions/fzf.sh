#   __                        __                  _   _
#  / _|_   _ _________   _   / _|_   _ _ __   ___| |_(_) ___  _ __  ___
# | |_| | | |_  /_  / | | | | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _| |_| |/ / / /| |_| | |  _| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|  \__,_/___/___|\__, | |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                    |___/
#
# This is a collection of functions that use the fzf fuzzy finder to help autocomplete
# many common commands.

# fkill - list processes using ps and select one to kill
fkill() {
  local pid

  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fd - list sub directories and select one to cd
fd() {
  local selected_directory
  selected_directory=$(find . -type d | grep -v '\.git' | fzf)

  if [[ -n $selected_directory ]]
  then
    cd $selected_directory
  fi
}

# fco - list all branches and select one to checkout
fco() {
  local selected_branch

  selected_branch=$(git branch --all | fzf -0)

  if [[ -n $selected_branch ]]
  then
    git checkout $(echo "$selected_branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
  fi
}

# frg - search files using ripgrep and select one
frg() {
  # TODO: Require param.
  # TODO: Handle no results.
  # TODO: Cleanup the selected result.
  rg --column --no-heading --hidden -i --color always $@ | grep -v '\.git' | fzf --ansi --preview '~/.functions/preview-search-result.sh {}'
}

# fj - list most recently used directories using fasd and select one to cd
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

# Select a frequently used directory.
alias j="fj"
# Go straight to the most frequently used directory.
alias jj="fasd -dlR | head -1"
