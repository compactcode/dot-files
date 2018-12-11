#   __                        __                  _   _
#  / _|_   _ _________   _   / _|_   _ _ __   ___| |_(_) ___  _ __  ___
# | |_| | | |_  /_  / | | | | |_| | | | '_ \ / __| __| |/ _ \| '_ \/ __|
# |  _| |_| |/ / / /| |_| | |  _| |_| | | | | (__| |_| | (_) | | | \__ \
# |_|  \__,_/___/___|\__, | |_|  \__,_|_| |_|\___|\__|_|\___/|_| |_|___/
#                    |___/
#
# This is a collection of functions that use the fzf fuzzy finder to help autocomplete
# many common commands.

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
  local search_pattern

  search_pattern=$1

  if [[ -z $search_pattern ]]
  then
    echo 'no search pattern given' && return 1
  else
    echo "$(\
      rg --column --no-heading --smart-case --color always $@ | \
      fzf --ansi --preview '~/.functions/fzf-column-preview.sh {}' | \
      awk -F ':' '{print $1}')"
  fi
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
alias jj="cd `fasd -dlR | head -1`"
