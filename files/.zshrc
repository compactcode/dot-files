ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

plugins=(autojump extract git rails3)

source $ZSH/oh-my-zsh.sh

source ~/.aliases/bundler.sh
source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/vim.sh

# Allow switching ruby versions with rbenv.
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# Allow overriding system default tools.
export PATH="/usr/local/bin:$PATH"
