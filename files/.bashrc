export EDITOR=vim

export FZF_DEFAULT_COMMAND="rg --files --hidden | grep -v '\.git'"
export FZF_DEFAULT_OPTS="--reverse --height 40%"

source ~/.aliases/bundler.sh
source ~/.aliases/git.sh
source ~/.aliases/utility.sh
source ~/.aliases/vim.sh

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/chruby/auto.sh

# Add custom homebrew tools to the path.
export PATH="/usr/local/bin:$PATH"

# Add npm to the path.
export PATH="/usr/local/share/npm/bin:$PATH"

# Add cargo tools to the path.
export PATH="$HOME/.cargo/bin:$PATH"

# Add cargo source .
export RUST_SRC_PATH="$HOME/.rustup/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src"
