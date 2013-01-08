export EDITOR=vim

source ~/.aliases/bundler.sh
source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/vim.sh

# Allow switching ruby versions with rbenv.
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# Allow overriding system default tools.
export PATH="/usr/local/bin:$PATH"

# Include homebrew installed c header file when compiling.
export C_INCLUDE_PATH="/usr/local/include"

# Adjust the ruby memory profile for faster startup times.
export RUBY_HEAP_MIN_SLOTS=1000000
export RUBY_HEAP_SLOTS_INCREMENT=1000000
export RUBY_HEAP_SLOTS_GROWTH_FACTOR=1
export RUBY_GC_MALLOC_LIMIT=1000000000
export RUBY_HEAP_FREE_MIN=500000
