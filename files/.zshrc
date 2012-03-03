ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(autojump bundler extract git rails3)

source $ZSH/oh-my-zsh.sh

source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/macvim.sh

export PATH="$HOME/.rbenv/bin:$PATH"
