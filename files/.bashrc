export CLICOLOR=1

source ~/.aliases/git.sh
source ~/.aliases/system.sh
source ~/.aliases/vim.sh

# Allow switching ruby versions with rbenv.
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

# Allow overriding system default tools.
export PATH="/usr/local/bin:$PATH"
