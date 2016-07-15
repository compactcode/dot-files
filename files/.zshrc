source $HOME/.bashrc

source ~/.scripts/git-prompt.sh

GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1

precmd () { __git_ps1 "%~ " "%s " }
