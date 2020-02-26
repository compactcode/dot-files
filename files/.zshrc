source $HOME/.bashrc

# Disable the pure prompt from making remote git fetch.
export PURE_GIT_PULL=0

export ZPLUG_HOME=/home/linuxbrew/.linuxbrew/opt/zplug
source $ZPLUG_HOME/init.zsh

zplug "modules/editor",    from:prezto # emacs key bindings.
zplug "modules/directory", from:prezto # automatic cd/pushd/popd etc.
zplug "modules/fasd",      from:prezto # cd to frequent/recent directories.
zplug "modules/history",   from:prezto # better command history.
zplug "modules/prompt",    from:prezto # prompt theme.

zstyle ':prezto:module:prompt' theme 'pure'

zplug load

source /home/linuxbrew/.linuxbrew/opt/fzf/shell/completion.zsh   # use fzf for glob completion
source /home/linuxbrew/.linuxbrew/opt/fzf/shell/key-bindings.zsh # use fzf for history etc

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
      fzf --ansi --preview '~/.local/share/sh/fzf-column-preview.sh {}' | \
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
