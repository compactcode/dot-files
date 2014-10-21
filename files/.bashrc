export EDITOR=vim

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
