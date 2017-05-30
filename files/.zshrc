source $HOME/.bashrc

source ~/.zplug/init.zsh

zplug "modules/autosuggestions", from:prezto # autocomplete commands.
zplug "modules/directory",       from:prezto # automatic cd/pushd/popd etc.
zplug "modules/fasd",            from:prezto # cd to a frequent/recent directories.
zplug "modules/history",         from:prezto # better history.
zplug "modules/prompt",          from:prezto # prompt theme.

zstyle ':prezto:module:prompt' theme 'pure'  # Use the pure prompt.

zplug load --verbose

source /usr/local/opt/fzf/shell/completion.zsh   # use fzf for glob completion
source /usr/local/opt/fzf/shell/key-bindings.zsh # use fzf for history etc

bindkey -e # Enable Emacs key bindings.
