source $HOME/.bashrc

setopt AUTO_PUSHD        # Auto push old directory during cd.
setopt PUSHD_IGNORE_DUPS # Do not store duplicates in the stack.
setopt PUSHD_SILENT      # Do not print the directory stack after pushd or popd.

source ~/.zplug/init.zsh

zplug "modules/history",   from:prezto # Persistent history.
zplug "modules/fasd",      from:prezto # Fast directory switching.
zplug "modules/prompt",    from:prezto # Prompt setup.

# Use the pure prompt.
zstyle ':prezto:module:prompt' theme 'pure'

zplug load --verbose

# Enable Emacs key bindings.
bindkey -e
