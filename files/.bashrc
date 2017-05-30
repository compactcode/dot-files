export EDITOR=vim

export FZF_DEFAULT_COMMAND="rg --files"
export FZF_DEFAULT_OPTS="--reverse --height 40%"

source ~/.aliases/bundler.sh
source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/vim.sh

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Add custom homebrew tools to the path.
export PATH="/usr/local/bin:$PATH"

# Add npm to the path.
export PATH="/usr/local/share/npm/bin:$PATH"
