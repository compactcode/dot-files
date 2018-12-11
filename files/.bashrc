export EDITOR=vim

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '\.git'"
export FZF_DEFAULT_OPTS="--reverse --height 40%"

source ~/.bash_aliases/bundler.sh
source ~/.bash_aliases/git.sh
source ~/.bash_aliases/rg.sh
source ~/.bash_aliases/utility.sh
source ~/.bash_aliases/vim.sh

# Add homebrew binaries to the path.
export PATH="/usr/local/bin:$PATH"

# Add npm binaries to the path.
export PATH="/usr/local/share/npm/bin:$PATH"

# Add cargo binaries to the path.
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby version management.
source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh
