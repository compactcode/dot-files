ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(git bundler gem rails3 ruby autojump)

source $ZSH/oh-my-zsh.sh

source ~/.aliases/git.sh
source ~/.aliases/system.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
