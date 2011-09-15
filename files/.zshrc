ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(autojump bundler brew extract git gem rails3 ruby)

source $ZSH/oh-my-zsh.sh

source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/macvim.sh

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"
