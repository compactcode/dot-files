export EDITOR=vim

source ~/.aliases/bundler.sh
source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/vim.sh

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Allow overriding system default tools.
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"

# Include homebrew installed c header file when compiling.
export C_INCLUDE_PATH="/usr/local/include"
